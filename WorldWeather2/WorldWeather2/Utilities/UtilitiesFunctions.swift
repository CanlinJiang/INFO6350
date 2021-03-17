//
//  UtilitiesFunctions.swift
//  WorldWeather2
//
//  Created by little tree on 3/16/21.
//

import Foundation
import CoreLocation

func getCityInfoUrl(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) -> String {
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
