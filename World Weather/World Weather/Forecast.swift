//
//  Forecast.swift
//  World Weather
//
//  Created by little tree on 3/11/21.
//

import Foundation

class Forecast {
    var date: String = ""
    var highTemperature = 0
    var lowTemperature = 0
    
    init(_ date: String, _ highTemperature: Int, _ lowTemperature: Int) {
        self.date = date
        self.highTemperature = highTemperature
        self.lowTemperature = lowTemperature
    }
    
    init() {
        
    }
}
