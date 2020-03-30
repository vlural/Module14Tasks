import UIKit

class TodoListRealmViewController: UIViewController {
    @IBOutlet weak var addTaskView: UIView!
    @IBOutlet weak var newTodoTaskTextField: UITextField!
    @IBOutlet weak var todoTableView: UITableView!
    
    var todoTasks: [TodoTask] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let todoTasksAll = Persistance.shared.getAllTaskRealm()
        for todoTask in todoTasksAll {
            todoTasks.insert(todoTask, at: 0)
        }
    }
    @IBAction func addTask(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.addTaskView.layer.opacity = 1
        })
    }
    @IBAction func saveTask(_ sender: Any) {
        if newTodoTaskTextField.text != "" {
            todoTasks.insert(Persistance.shared.addTaskRealm(name: newTodoTaskTextField.text!), at: 0)
        }
        todoTableView.reloadData()
        UIView.animate(withDuration: 0.3, animations: {
            self.addTaskView.layer.opacity = 0
        })
        newTodoTaskTextField.text = ""
    }
}

extension TodoListRealmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTaskCell", for: indexPath) as! TodoTaskTableViewCell
        cell.todoTaskNameLabel.text = todoTasks[indexPath.item].name
        cell.doneButton.setBackgroundImage(nil, for: .normal)
        if todoTasks[indexPath.item].done {
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
