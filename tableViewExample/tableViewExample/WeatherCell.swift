//
//  weatherCell.swift
//  tableViewExample
//
//  Created by little tree on 3/24/21.
//

import Foundation
import UIKit //important

class WeatherCell {
    var dayOfTheWeek : String = ""
    var maxTemp : Int = -1
    var minTemp : Int = -1
    var image: UIImage?
    
    init(_ dayOfTheWeek : String, _ maxTemp : Int, _ minTemp : Int, _ imageName: String) {
        self.dayOfTheWeek = dayOfTheWeek
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.image = UIImage(named: imageName)
    }
    
    
}
