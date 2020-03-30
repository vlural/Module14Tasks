import UIKit

class TodoTaskTableViewCellCoreData: UITableViewCell {
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
        let todoTasksAll = Persistance.shared.getAllTaskCoreData()
        if todoTasksAll != nil {
            Persistance.shared.delTodoTaskCoreData(id: todoTasksAll![todoTasksAll!.count - itemNumber - 1].value(forKey: "id") as! Int)
            afterDelete!()
        }
    }
    @IBAction func doneTask(_ sender: Any) {
        let todoTasksAll = Persistance.shared.getAllTaskCoreData()
        if todoTasksAll != nil {
            Persistance.shared.doneTodoTaskCoreData(id: todoTasksAll![todoTasksAll!.count - itemNumber - 1].value(forKey: "id") as! Int)
            afterDone!()
        }
    }
}
