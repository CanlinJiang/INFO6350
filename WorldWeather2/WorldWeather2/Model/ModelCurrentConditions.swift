//
//  ModelCurrentConditions.swift
//  WorldWeather2
//
//  Created by little tree on 3/16/21.
//

import Foundation

class ModelCurrentConditions{
    var weatherText: String = ""
    var weatherIcon: Int = 0
    var isDayTime: Bool = true
    var metricTemperature: Float = 0.0
    var imperialTemperature: Int = 0
    
    init(_ weatherText: String, _ weatherIcon: Int, _ isDayTime: Bool, _ metricTemperature: Float, _ imperialTemperature: Int){
        self.weatherText = weatherText
        self.weatherIcon = weatherIcon
        self.isDayTime  = isDayTime
        self.metricTemperature = metricTemperature
        self.imperialTemperature = imperialTemperature
    }
}
