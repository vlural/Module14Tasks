import Foundation
import RealmSwift

class TodoTask: Object {
    @objc dynamic var name = ""
    @objc dynamic var id = 1
    @objc dynamic var done = false
}
