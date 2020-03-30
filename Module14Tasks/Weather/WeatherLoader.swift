import Foundation
import Alamofire

class WeatherLoader {
    
    func loadWeatherAlamofire(completion: @escaping ([Weather]) -> Void) {
        var weatherList: [Weather] = []
        self.loadCurrentWeatherAlamofire{ currentWeatherList in
            weatherList += currentWeatherList
            self.loadForecastWeatherAlamofire{ forecastWeatherList in
                weatherList += forecastWeatherList
                completion(weatherList)
            }
        }
    }
    
    func loadCurrentWeatherAlamofire(completion: @escaping ([Weather]) -> Void) {
        AF.request("http://api.openweathermap.org/data/2.5/weather?id=524894&appid=437c2894f86bce0bd962f6fd269cdfc6&units=metric&lang=ru").responseJSON
            { response in
                if let objects = response.value,
                    let jsonDict = objects as? NSDictionary {
                    var weatherList: [Weather] = []
                    if let weatherInfo = Weather(data: jsonDict as! NSDictionary) {
                        weatherList.append(weatherInfo)
                    }
                    DispatchQueue.main.async {
                        completion(weatherList)
                    }
                }
        }
    }
    
    func loadForecastWeatherAlamofire(completion: @escaping ([Weather]) -> Void) {
        AF.request("http://api.openweathermap.org/data/2.5/forecast?id=524894&appid=437c2894f86bce0bd962f6fd269cdfc6&units=metric&lang=ru").responseJSON
            { response in
                if let objects = response.value,
                    let jsonDict = objects as? NSDictionary {
                    var weatherList: [Weather] = []
                    let weatherData = jsonDict.object(forKey: "list") as! [NSDictionary]
                    for (key, _) in weatherData.enumerated(){
                        let weatherDataElement = weatherData[key] as! NSDictionary
                        if let weatherInfo = Weather(data: weatherDataElement) {
                            weatherList.append(weatherInfo)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completion(weatherList)
                    }
                }
        }
    }
}

