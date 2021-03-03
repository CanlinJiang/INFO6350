//
//  Stock.swift
//  GetStockValue
//
//  Created by little tree on 3/2/21.
//

import Foundation
import RealmSwift

class Stock: Object {
    @objc dynamic var symbol: String = ""
    @objc dynamic var price: Float = 0.0
    @objc dynamic var volume: Int = 0
//
//    override static func primaryKey() -> String? {
//        return "littletreellovo"
//    }
    
    override init() {
        return
    }
    
    init(_ symbol: String, _ price: Float, _ volume: Int) {
        self.symbol = symbol;
        self.price = price;
        self.volume = volume;
    }
}
