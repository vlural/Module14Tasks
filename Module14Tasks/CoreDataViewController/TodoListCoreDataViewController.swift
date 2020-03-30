import UIKit
import CoreData

class TodoListCoreDataViewController: UIViewController {
    @IBOutlet weak var addTaskView: UIView!
    @IBOutlet weak var newTodoTaskTextField: UITextField!
    @IBOutlet weak var todoTableView: UITableView!
    
    var todoTasks: [NSManagedObject?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoTasks = Persistance.shared.getAllTaskCoreData()?.reversed() ?? []
    }
    @IBAction func addTask(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.addTaskView.layer.opacity = 1
        })
    }
    @IBAction func saveTask(_ sender: Any) {
        if newTodoTaskTextField.text != "" {
            let newTodoTask = Persistance.shared.addTaskCoreData(name: newTodoTaskTextField.text!)
            todoTasks.insert(newTodoTask, at: 0)
        }
        todoTableView.reloadData()
        UIView.animate(withDuration: 0.3, animations: {
            self.addTaskView.layer.opacity = 0
        })
        newTodoTaskTextField.text = ""
    }
}

extension TodoListCoreDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTaskCell", for: indexPath) as! TodoTaskTableViewCellCoreData
        cell.todoTaskNameLabel.text = todoTasks[indexPath.item]?.value(forKey: "name") as! String
        cell.doneButton.setBackgroundImage(nil, for: .normal)
        if todoTasks[indexPath.item]?.value(forKey: "done") as! Bool {
            cell.doneButton.setBackgroundImage(UIImage(named: "check"), for: .normal)
        }
        cell.itemNumber = indexPath.item
        cell.afterDelete = {
            self.todoTasks.remove(at: indexPath.item);
            self.todoTableView.reloadData()
        }
        cell.afterDone = {
            self.todoTableView.reloadData()
        }
        return cell
    }
}
