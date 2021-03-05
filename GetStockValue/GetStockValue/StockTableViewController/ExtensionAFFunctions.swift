//
//  ExtensionAFFunctions.swift
//  GetStockValue
//
//  Created by little tree on 3/4/21.
//


import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON
import RealmSwift



extension StockTableViewController {
    @objc func getData(){
        if symbolArray.count == 0 {
            return
        }
        let url = getURL();
        
        SwiftSpinner.show("Getting Stock Values")
        AF.request(url).responseJSON{response in
            SwiftSpinner.hide()
            if response.error == nil {
                guard let data = response.data else {return}
                guard let stocksData = JSON(data).array else{return}
                if (stocksData.count == 0) {
                    return
                }
                self.stocksArray.removeAll()
                for stockData in stocksData {
                    let stock = Stock();
                    stock.symbol = stockData["symbol"].stringValue
                    stock.price = stockData["price"].floatValue
                    stock.volume = stockData["volume"].intValue
                    self.stocksArray.append(stock)
                    //print("Current stock: \(stock)")
                    self.addToRealmDataBase(stock)
                   
                }
            } else {
                print(response.error?.localizedDescription)
            }
            self.tableOfStock.reloadData();
        }
    }
    
    func getURL() -> String {
        var url : String = apiURL;
        for symbol in symbolArray {
            url.append(symbol + ",")
        }
        url = String(url.dropLast())
        
        url += "?apikey=" + apiKey
        
        return url;
    }

}
