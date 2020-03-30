import UIKit

class TodoTaskTableViewCell: UITableViewCell {
    @IBOutlet weak var todoTaskNameLabel: UILabel!
    var itemNumber = 0
    var afterDelete: (() -> Void)?
    var afterDone: (() -> Void)?
    @IBOutlet weak var doneButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doneButton.layer.borderWidth = 1
        doneButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        let todoTasksAll = Persistance.shared.getAllTaskRealm()
        Persistance.shared.delTodoTask(todoTask: todoTasksAll[todoTasksAll.count - itemNumber - 1])
        afterDelete!()
    }
    
    @IBAction func doneTask(_ sender: Any) {
        let todoTasksAll = Persistance.shared.getAllTaskRealm()
        Persistance.shared.doneTodoTask(todoTask: todoTasksAll[todoTasksAll.count - itemNumber - 1])
        afterDone!()
    }
}
