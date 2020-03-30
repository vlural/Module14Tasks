import Foundation
import RealmSwift
import CoreData

class Persistance {
    static let shared = Persistance()
    
    private let realm = try! Realm()
    
    func addTaskRealm(name: String) -> TodoTask {
        let todoTaskInRealm = self.getAllTaskRealm().last
        let todoTask = TodoTask()
        try! realm.write {
            todoTask.name = name
            todoTask.id = todoTaskInRealm == nil ? 1 : todoTaskInRealm!.id + 1
            todoTask.done = false
            realm.add(todoTask)
        }
        return todoTask
    }
    
    func addTaskCoreData(name: String) -> TodoTaskCD? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let TodoTaskCDEntity = NSEntityDescription.entity(forEntityName: "TodoTaskCD", in: managedContext) else { return nil }
        let todoTask = NSManagedObject(entity: TodoTaskCDEntity, insertInto: managedContext)
        let todoTasksAll = self.getAllTaskCoreData()
        var newId = 1
        if todoTasksAll != nil {
            newId = todoTasksAll!.last!.value(forKey: "id") as! Int + 1
        }
        todoTask.setValue(name, forKey: "name")
        todoTask.setValue(newId, forKey: "id")
        todoTask.setValue(false, forKey: "done")
        try! managedContext.save()
        return todoTask as! TodoTaskCD
    }
    
    func getAllTaskRealm() -> Results<TodoTask> {
        return realm.objects(TodoTask.self).sorted(byKeyPath: "id")
    }
    
    func getAllTaskCoreData() -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoTaskCD")
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        let result = try! managedContext.fetch(fetchRequest)
        return result as? [NSManagedObject]
    }
    
    func delTodoTask(todoTask: TodoTask) {
        try! realm.write {
            realm.delete(todoTask)
        }
    }
    
    func delTodoTaskCoreData(id: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoTaskCD")
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        let resultObjectToDelete = try! managedContext.fetch(fetchRequest)
        let objectToDelete = resultObjectToDelete[0] as! NSManagedObject
        managedContext.delete(objectToDelete)
        try! managedContext.save()
    }
    
    func doneTodoTask(todoTask: TodoTask) {
        try! realm.write {
            todoTask.done = !todoTask.done
        }
    }
    
    func doneTodoTaskCoreData(id: Int) {        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoTaskCD")
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        let resultObjectToUpdate = try! managedContext.fetch(fetchRequest)
        let objectToUpdate = resultObjectToUpdate[0] as! NSManagedObject
        let newDoneValue = objectToUpdate.value(forKey: "done") as! Bool
        objectToUpdate.setValue(!newDoneValue, forKey: "done")
        try! managedContext.save()
    }
}
