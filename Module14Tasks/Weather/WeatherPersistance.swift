import Foundation
import RealmSwift

class WeatherPersistance {
    static let shared = WeatherPersistance()
    
    private let realm = try! Realm()
    
    func addWeatherRealm(weather: Weather) {
        try! realm.write {
            realm.add(weather)
        }
    }
    
    func addWeatherRealm(weatherList: [Weather]) {
        for weather in weatherList {
            addWeatherRealm(weather: weather)
        }
    }
    
    func loadWeatherRealm() -> [Weather]? {
        let objects = realm.objects(Weather.self).toArray()
        return objects.count > 0 ? objects : nil
    }
    
    func clearWeather() {
        let objectsToDelete = realm.objects(Weather.self)
        try! realm.write {
           realm.delete(objectsToDelete)
        }        
    }
}

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}
