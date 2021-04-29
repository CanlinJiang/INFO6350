//
//  Services.swift
//  NewsApp
//
//  Created by little tree on 4/28/21.
//

import Foundation
import SwiftyJSON
import Alamofire
import PromiseKit
import UIKit

func getAFResponseJSON(_ url: String) -> Promise<JSON> {
    return Promise<JSON> {seal -> Void in
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                seal.fulfill(json)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
    }
}
}

func getAFResponseImage(_ url: String) -> Promise<UIImage> {
    return Promise<UIImage> {seal -> Void in
        AF.request(url,method: .get).response{ response in

           switch response.result {
            case .success(let responseData):
                guard let image = UIImage(data: responseData!, scale:1) else {return}
                seal.fulfill(image)
            case .failure(let error):
                print("error--->",error)
            }
        }
    }
}



