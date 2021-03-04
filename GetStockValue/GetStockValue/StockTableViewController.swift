//
//  StockTableViewController.swift
//  GetStockValue
//
//  Created by little tree on 3/2/21.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON
import RealmSwift

class StockTableViewController: UITableViewController {
    var symbolArray: [String] = [String]()
    var stocksArray: [Stock] = [Stock]()
    var globalStockTextField : UITextField?
    
    @IBOutlet var tableOfStock: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        do {
//            let realm = try Realm()
////            try realm.write {
////                realm.add(stock)
////            }
//        } catch {
//            print("ERROR in initialzing realm")
//        }
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //getData()
        loadReamStocks()
    }
    
    
    func getData(){
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
                    print("Current stock: \(stock)")
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

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stocksArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell

        cell.labelSymbol.text = "\(stocksArray[indexPath.row].symbol): "
        cell.labelPrice.text = "$\(String(stocksArray[indexPath.row].price))"

        return cell
    }
    
    @IBAction func addStock(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Get Stock Price?", message: "Type in the Symbol", preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            print("OK")
            guard let stockSymbol = self.globalStockTextField?.text?.uppercased() else {return}
            if stockSymbol == "" {
                return
            }
            print("Current Symbol: \(stockSymbol)")
            self.symbolArray.append(stockSymbol)
            print("Current Symbol Array: \(self.symbolArray)")
            self.getData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            print ("Cancel")
        }
        
        alert.addTextField { (stockTextField) in
            stockTextField.placeholder = "Type Stock Symbol"
            self.globalStockTextField = stockTextField
        }
        
        alert.addAction(OK)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
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
    
//    func doesStockExist(_ stock: Stock) -> Bool{
//        let realm = try! Realm()
//        if realm.object(ofType: Stock.self, forPrimaryKey: stock.symbol) != nil {
//            return true
//        } else {
//            return false
//        }
//    }
    
    func loadReamStocks(){
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
    }
    
}

    

