//
//  ViewController.swift
//  WorldWeather2
//
//  Created by little tree on 3/16/21.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import RealmSwift
import PromiseKit

class WorldWeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCondition: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblHighLow: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeText()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    func initializeText(){
        self.title = strWorldWeather
        self.lblCity.text = strCity
        self.lblCondition.text = strCondition
        self.lblTemperature.text = strTemperature
        self.lblHighLow.text = strHighLow
    }
    
    let locationManager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let currLocation = locations.last{
            let latitude = currLocation.coordinate.latitude
            let longitude = currLocation.coordinate.longitude
            //updateWeather(latitude, longitude)
        }
    }
    
    let viewModel = WorldWeatherViewModel()
    func updateWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) {

        let cityInfoUrl = getCityInfoUrl(latitude, longitude)
        self.viewModel.getCityInfo(cityInfoUrl)
            .done { cityInfo in
                self.lblCity.text = cityInfo.cityName
                
                let key = cityInfo.cityKey
                
                //get current condition
                let currentConditionsUrl = getCurrentConditionUrl(key)
                self.viewModel.getCurrentConditions(currentConditionsUrl)
                    .done{ currentConditions in
                        self.lblCondition.text = currentConditions.weatherText
                        self.lblTemperature.text = " \(currentConditions.imperialTemperature)°"
                    }
                    .catch { error in
                        print("Error in getting city's current condition: \(error.localizedDescription)")
                    }
                
                //get highest and lowest temperature
                let oneDayForecastsUrl = getOneDayForcastsUrl(key)
                self.viewModel.getOneDayForecasts(oneDayForecastsUrl)
                    .done{ forecasts in
                        self.lblHighLow.text = "H: \(forecasts.maximumTemperature)° L: \(forecasts.minimumTemperature)°"
                    }
                    .catch { error in
                        print("Error in getting city's maximum and minimum temperature: \(error.localizedDescription)")
                    }
                
//                //get 5 days forecasts: date, highest and lowest temperature
//                let fiveDaysForecastsUrl = self.getFiveDaysForecastsUrl(key)
//                self.getFiveDaysForecasts(fiveDaysForecastsUrl)
//                    .done{ forecastsArray in
//                        self.forecasts.removeAll()
//                        for forecast in forecastsArray {
//                            self.forecasts.append(forecast)
//                        }
//                        self.tblView.reloadData()
//                    }
//                    .catch { error in
//                        print("Error in getting city's maximum and minimum temperature: \(error.localizedDescription)")
//                    }
            }
            .catch { error in
                print("Error in getting city's key and name: \(error.localizedDescription)")
            }
    }


}

