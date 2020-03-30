import Foundation
import RealmSwift

class Weather: Object {
    @objc dynamic var dateTime: Int = 0
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var pressure: Int = 0
    @objc dynamic var humidity: Int = 0
    @objc dynamic var clouds: String = ""
    
    convenience init?(data: NSDictionary) {
        self.init()
        guard let dateTime = data["dt"] as? Int,
            let main = data["main"] as? NSDictionary,
            let weatherWrapper = data["weather"] as? NSArray else {
                return nil
        }
        guard let weather = weatherWrapper[0] as? NSDictionary else {
                return nil
        }
        guard let temp = main["temp"] as? Double,
            let pressure = main["pressure"] as? Int,
            let humidity = main["humidity"] as? Int,
            let clouds = weather["description"] as? String else {
                return nil
        }
        self.dateTime = dateTime
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.clouds = clouds
    }
}
