//
//  ViewController.swift
//  World Weather
//
//  Created by little tree on 3/9/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import RealmSwift
import PromiseKit

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCondition: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblHighLow: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeText()
        tblView.delegate = self
        tblView.dataSource = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBOutlet weak var lblHelloWorld: UILabel!
    func initializeText(){
        lblHelloWorld.text = strHelloWorld
    }
    
    //Table view of 5 days forecast
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var dateOfTableView: UILabel!
    @IBOutlet weak var highTemperatureOfTableView: UILabel!
    @IBOutlet weak var lowTemperatureOfTableView: UILabel!
    
    var forecasts : [Forecast] = [Forecast]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("fiveDaysForecastsTableViewCell", owner: self, options: nil)?.first as! fiveDaysForecastsTableViewCell
        
        let date = self.forecasts[indexPath.row].date
        let start = date.index(date.startIndex, offsetBy: 5)
        let end = date.index(date.endIndex, offsetBy: -16)
        cell.date.text = String(date[start...end])
        cell.highTemperature.text = String(self.forecasts[indexPath.row].highTemperature)
        cell.lowTemperature.text = String(self.forecasts[indexPath.row].lowTemperature)
        
        return cell
    }
 
    let locationManager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(1)
        if let currLocation = locations.last{
            let latitude = currLocation.coordinate.latitude
            let longitude = currLocation.coordinate.longitude
            updateWeather(latitude, longitude)
        }
    }
}


//MARK: Uppdate weather condition
extension ViewController {
    func updateWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {
        let locationAndKeyUrl = getLocationAndKeyUrl(latitude, longitude)
        getLocationAndKey(locationAndKeyUrl)
            .done { (key, city) in
                self.lblCity.text = city
                
                //get current condition
                let currentConditionUrl = self.getCurrentConditionUrl(key)
                self.getCurrentCondition(currentConditionUrl)
                    .done{ (condition, temperature) in
                        self.lblCondition.text = condition
                        self.lblTemperature.text = " \(temperature)°"
                    }
                    .catch { error in
                        print("Error in getting city's current condition: \(error.localizedDescription)")
                    }
                
                //get highest and lowest temperature
                let oneDayForecastUrl = self.getOneDayForcastsUrl(key)
                self.getOneDayForcasts(oneDayForecastUrl)
                    .done{ forecast in
                        self.lblHighLow.text = "H: \(forecast.highTemperature)° L: \(forecast.lowTemperature)°"
                    }
                    .catch { error in
                        print("Error in getting city's maximum and minimum temperature: \(error.localizedDescription)")
                    }
                
                //get 5 days forecasts: date, highest and lowest temperature
                let fiveDaysForecastsUrl = self.getFiveDaysForecastsUrl(key)
                self.getFiveDaysForecasts(fiveDaysForecastsUrl)
                    .done{ forecastsArray in
                        self.forecasts.removeAll()
                        for forecast in forecastsArray {
                            self.forecasts.append(forecast)
                        }
                        self.tblView.reloadData()
                    }
                    .catch { error in
                        print("Error in getting city's maximum and minimum temperature: \(error.localizedDescription)")
                    }
            }
            .catch { error in
                print("Error in getting city's key and name: \(error.localizedDescription)")
            }
    }
}

//MARK: Get URLs
extension ViewController {
    func getLocationAndKeyUrl(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) -> String {
        var url = getLocationAndKeyReferer
        url.append("?apikey=\(apiKey)")
        url.append("&q=\(latitude)%2C%20\(longitude)")
        return url
    }
    
    func getCurrentConditionUrl(_ key: String) -> String {
        var url = currentConditionReferer
        url.append(key)
        url.append("?apikey=\(apiKey)")
        return url
    }
    
    func getOneDayForcastsUrl(_ key: String) -> String {
        var url = oneDayForecastsReferer
        url.append(key)
        url.append("?apikey=\(apiKey)")
        return url
    }
    
    func getFiveDaysForecastsUrl(_ key: String) -> String {
        var url = fiveDaysForecastsReferer
        url.append(key)
        url.append("?apikey=\(apiKey)")
        return url
    }
}

//MARK: Promises
extension ViewController {
    func getLocationAndKey(_ url: String) -> Promise<(String, String)>{
        return Promise<(String, String)> { seal -> Void in
            
            AF.request(url).responseJSON { (response) in
                if (response.error != nil) {
                    seal.reject(response.error!)
                }
                
                let responseJson: JSON = JSON(response.data as Any)
                let key = responseJson["Key"].stringValue
                let city = responseJson["LocalizedName"].stringValue
                
                seal.fulfill((key, city))
            }
        }
    }
    
    func getCurrentCondition(_ url: String) -> Promise<(String, Int)> {
        return Promise<(String, Int)> {seal -> Void in
            AF.request(url).responseJSON { (response) in
                if (response.error != nil) {
                    seal.reject(response.error!)
                }
                
                guard let responseJson = JSON(response.data).array else {return seal.fulfill(("", 0))}
                let weather = responseJson[0]["WeatherText"].stringValue
                let temperature = responseJson[0]["Temperature"]["Imperial"]["Value"].intValue
                seal.fulfill((weather, temperature))
            }
            
        }
    }
    
    func getOneDayForcasts(_ url: String) -> Promise<Forecast> {
        return Promise<Forecast> {seal -> Void in
            AF.request(url).responseJSON { (response) in
                if (response.error != nil) {
                    seal.reject(response.error!)
                }
                let responseJson = JSON(response.data!)
                
                let date = responseJson["DailyForecasts"][0]["Date"].stringValue
                let highTemperature = responseJson["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].intValue
                let lowTemperature = responseJson["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].intValue
                var forecast = Forecast(date, highTemperature, lowTemperature)
                    
                seal.fulfill(forecast)
            }
        }
    }
    
    func getFiveDaysForecasts(_ url: String) -> Promise<[Forecast]> {
        return Promise<[Forecast]> {seal -> Void in
            AF.request(url).responseJSON { (response) in
                
                if (response.error != nil) {
                    seal.reject(response.error!)
                }
                let responseJson = JSON(response.data!)
                let forecastsData = responseJson["DailyForecasts"].array
                
                var forecasts: [Forecast] = [Forecast]()
                for forecast in forecastsData! {
                    let highTemperature = forecast["Temperature"]["Maximum"]["Value"].intValue
                    let lowTemperature = forecast["Temperature"]["Minimum"]["Value"].intValue
                    let date = forecast["Date"].stringValue
                    forecasts.append(Forecast(date, highTemperature, lowTemperature))
                }
                seal.fulfill(forecasts)
            }
        }
    }
}
