//
//  CovidTableViewModel.swift
//  covidDataTableView
//
//  Created by little tree on 3/30/21.
//

import Foundation
import PromiseKit

class CovidTableViewModel{
    func getCurrentConditions(_ url : String) -> Promise<[Covid]>{
        return Promise<[Covid]> { seal ->Void in
            
            getAFResponseJSONArray(url).done { data in
                var covidArray: [Covid] = [Covid]()
                for eachState in data {
                    let covid: Covid = Covid(eachState["state"].stringValue, eachState["total"].intValue, eachState["positive"].intValue)
                    
                    covidArray.append(covid)
                    
                }
                seal.fulfill(covidArray)
                
            }
            .catch { error in
                seal.reject(error)
            }
            
        }
}
}
