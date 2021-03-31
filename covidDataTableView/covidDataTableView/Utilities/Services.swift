//
//  Services.swift
//  covidDataTableView
//
//  Created by little tree on 3/30/21.
//

import Foundation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import PromiseKit

func getAFResponseJSONArray(_ url : String ) -> Promise<[JSON]>{
    //SwiftSpinner.show("Loading")
    return Promise< [JSON] > { seal ->Void in
        //SwiftSpinner.hide()
        AF.request(url).responseJSON { response in
            
            // If there was an error we will reject the promise
            if response.error != nil {
                seal.reject(response.error!)
            }
            
            // get the JSON array and fulfill the promise
            let jsonArray: [JSON] = JSON(response.data).arrayValue
            seal.fulfill(jsonArray)
            //print(jsonArray)
        }
    }
}
