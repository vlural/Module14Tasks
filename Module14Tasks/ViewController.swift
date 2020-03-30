import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surenameTextfield: UITextField!
    
    var name: String? {
        set { UserDefaults.standard.set(newValue, forKey: "name")}
        get { return UserDefaults.standard.string(forKey: "name")}
    }
    var surename: String? {
        set { UserDefaults.standard.set(newValue, forKey: "surename")}
        get { return UserDefaults.standard.string(forKey: "surename")}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = (name != nil) ? name : ""
        surenameTextfield.text = (surename != nil) ? surename : ""
    }
    
    @IBAction func saveDataButton(_ sender: Any) {
        name = nameTextField.text
        surename = surenameTextfield.text
    }
}

