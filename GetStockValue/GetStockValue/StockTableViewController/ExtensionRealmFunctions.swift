//
//  ExtensionRealmFunctions.swift
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
    func addToRealmDataBase(_ stock: Stock){
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(stock, update: .all)
            }
        } catch {
            print("ERROR in initialzing realm")
        }
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func deleteFromRealmDataBase(_ stock: Stock) {
        do {
            let realm = try! Realm()
            try! realm.write({
                realm.delete(stock)
            })
        } catch {
            print(error)
        }
    }
    
//    func doesStockExist(_ stock: Stock) -> Bool{
//        let realm = try! Realm()
//        if realm.object(ofType: Stock.self, forPrimaryKey: stock.symbol) != nil {
//            return true
//        } else {
//            return false
//        }
//    }
    
    @objc func loadRealmStock(){
        do {
            let realm = try! Realm()
            let stocks = realm.objects(Stock.self)
            symbolArray.removeAll();
            for stock in stocks {
                symbolArray.append(stock.symbol)
            }
            getData()
        } catch {
            print("Error in loading values from realm database: \(error)")
        }
        self.refreshControl?.endRefreshing()
        print("CURRENTARR: \(symbolArray)")
    }
}
