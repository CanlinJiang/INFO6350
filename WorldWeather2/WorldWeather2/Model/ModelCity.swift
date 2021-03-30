//
//  CityInfo.swift
//  WorldWeather2
//
//  Created by little tree on 3/16/21.
//

import Foundation

class ModelCity{
    var cityKey: String = ""
    var cityName: String = ""
    
    init(_ cityKey: String, _ cityName: String) {
        self.cityKey = cityKey
        self.cityName = cityName
    }
    init() {
    }
    
}


