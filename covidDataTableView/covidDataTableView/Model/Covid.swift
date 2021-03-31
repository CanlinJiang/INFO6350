//
//  Covid.swift
//  covidDataTableView
//
//  Created by little tree on 3/30/21.
//

import Foundation

class Covid {
    var state: String = ""
    var total: Int = -1
    var positive: Int = -1
    
    init() {
        
    }
    init(_ state: String, _ total: Int, _ positive: Int) {
        self.state = state;
        self.total = total
        self.positive = positive
    }
}
