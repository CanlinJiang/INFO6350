//
//  CityViewModel.swift
//  WorldWeather2
//
//  Created by little tree on 3/16/21.
//

import Foundation
import PromiseKit

class WorldWeatherViewModel{
    var city: ModelCity = ModelCity();
    
    func getCityInfo(_ url: String) -> Promise<ModelCity>{
        return Promise<ModelCity> { seal -> Void in
            getAFResponseJSON(url).done { JSON in
                let key = JSON["Key"].stringValue
                let city = JSON["LocalizedName"].stringValue
                seal.fulfill(ModelCity(key, city))
            }
            .catch { error in
                seal.reject(error)
            }
        }
    }
    
    func getCurrentConditions(_ url: String) -> Promise<ModelCurrentConditions>{
        return Promise<ModelCurrentConditions> { seal -> Void in
            getAFResponseJSONArray(url)
                .done{JSONArray in
                    let weatherText = JSONArray[0]["WeatherText"].stringValue
                    let weatherIcon = JSONArray[0]["WeatherIcon"].intValue
                    let isDayTime = JSONArray[0]["IsDayTime"].boolValue
                    let metricTemperature = JSONArray[0]["Temperature"]["Metric"]["Value"].floatValue
                    let imperialTemperature = JSONArray[0]["Temperature"]["Imperial"]["Value"].intValue
                    let currentConditions: ModelCurrentConditions = ModelCurrentConditions(weatherText, weatherIcon, isDayTime, metricTemperature, imperialTemperature)
                    seal.fulfill(currentConditions)
                }
                .catch{error in
                    seal.reject(error)
                }
        }
    }
    
    func getOneDayForecasts(_ url: String) -> Promise<ModelOneDayForcast> {
        return Promise<ModelOneDayForcast> {
            seal -> Void in
            getAFResponseJSON(url)
                .done{ responseJson in
                    var forecast: ModelOneDayForcast = ModelOneDayForcast()
                    forecast.headlineText = responseJson["Headline"]["Text"].stringValue
                    forecast.minimumTemperature = responseJson["DailyForecasts"][0]["Temperature"]["Minimum"]["Value"].intValue
                    forecast.maximumTemperature = responseJson["DailyForecasts"][0]["Temperature"]["Maximum"]["Value"].intValue
                    forecast.dayIcon = responseJson["DailyForecasts"][0]["Day"]["Icon"].intValue
                    forecast.dayIconPhrase = responseJson["DailyForecasts"][0]["Day"]["IconPhrase"].stringValue
                    forecast.nightIcon = responseJson["DailyForecasts"][0]["Night"]["Icon"].intValue
                    forecast.nightIconPhrase = responseJson["DailyForecasts"][0]["Night"]["IconPhrase"].stringValue
                    seal.fulfill(forecast)
                }.catch { error in
                    seal.reject(error)
                } 
            }
        }
    }
    
    
    

