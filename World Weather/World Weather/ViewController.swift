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

class ViewController: UIViewController, CLLocationManagerDelegate{
 
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCondition: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblHighLow: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

//    @IBAction func getLocation(_ sender: Any) {
//        locationManager.requestLocation()
//    }
//
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
                        self.lblTemperature.text = "\(temperature)F"
                    }
                    .catch { error in
                        print("Error in getting city's current condition: \(error.localizedDescription)")
                    }
                
                //get highest and lowest temperature
                let highLowUrl = self.getHighLowUrl(key)
                self.getHighLowCondition(highLowUrl)
                    .done{ (highTemperature, lowTemperature) in
                        self.lblHighLow.text = "High: \(highTemperature), Low: \(lowTemperature)"
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
    
    func getHighLowUrl(_ key: String) -> String {
        var url = currentHighLowReferer
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
    
    func getHighLowCondition(_ url: String) -> Promise<(Int, Int)> {
        return Promise<(Int, Int)> {seal -> Void in
            AF.request(url).responseJSON { (response) in
                if (response.error != nil) {
                    seal.reject(response.error!)
                }
                
                let responseJson = JSON(response.data)
                let highTemperature = responseJson["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].intValue
                let lowTemperature = responseJson["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].intValue
                    
                print(highTemperature, lowTemperature)
                seal.fulfill((highTemperature, lowTemperature))
            }
        }
    }
}
