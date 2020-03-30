import UIKit

class WeatherViewController: UIViewController {
    var weatherList: [Weather] = []
    @IBOutlet weak var alamofireTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherList = WeatherPersistance.shared.loadWeatherRealm() ?? []
        self.alamofireTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        WeatherLoader().loadWeatherAlamofire{ weatherList in
            self.weatherList = weatherList
            self.alamofireTableView.reloadData()
            WeatherPersistance.shared.clearWeather()
            WeatherPersistance.shared.addWeatherRealm(weatherList: weatherList)
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell
        let model = weatherList[indexPath.row]
        
        let date = NSDate(timeIntervalSince1970: Double(model.dateTime))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd.MM.YYYY HH:mm"
        cell.dateTimeLabel.text = dayTimePeriodFormatter.string(from: date as Date)
        
        cell.tempLabel.text! = "Температура:    \(String(model.temp)) ℃"
        cell.pressureLabel.text! = "Давление:    \(String(model.pressure))"
        cell.humidityLabel.text! = "Влажность:    \(String(model.humidity))"
        cell.cloudsLabel.text! = "Облачность:    \(String(model.clouds))"
        return cell
    }
}
