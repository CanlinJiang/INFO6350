//
//  Services.swift
//  WorldWeather2
//
//  Created by little tree on 3/16/21.
//

import Foundation
import Alamofire
import SwiftSpinner
import SwiftyJSON
import RealmSwift
import PromiseKit

func getAFResponseJSONArray(_ url: String) -> Promise<[JSON]> {
    return Promise<[JSON]> {seal -> Void in
        AF.request(url).responseJSON { (response) in
            
            if (response.error != nil) {
                seal.reject(response.error!)
            }
            guard let jsonArray: [JSON] = JSON(response.data!).array else { return seal.fulfill([JSON]()) }
            seal.fulfill(jsonArray)
        }
    }
}


func getAFResponseJSON(_ url: String) -> Promise<JSON> {
    return Promise<JSON> {seal -> Void in
        AF.request(url).responseJSON { response in
            
            if (response.error != nil) {
                seal.reject(response.error!)
            }
            let responseJson = JSON(response.data!)
            
            seal.fulfill(responseJson)
        }
    }
}
