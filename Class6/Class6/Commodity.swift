//
//  Commodity.swift
//  Class6
//
//  Created by little tree on 3/5/21.
//

import Foundation
import RealmSwift


class Commodity: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var price: Float = 0.0
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    override init() {
        return
    }
    
    init(_ name: String, _ price: Float) {
        self.name = name;
        self.price = price;
    }
}
