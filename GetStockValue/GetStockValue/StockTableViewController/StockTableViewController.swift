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
        /*do {
            let realm = try Realm()ssssssss
//            try realm.write {
//                realm.add(stock)
//            }
        } catch {
            print("ERROR in initialzing realm")
        }
        print(Realm.Configuration.defaultConfiguration.fileURL)*/
        
    }
    override func viewWillAppear(_ animated: Bool) {
        //getData()
        loadRealmStock()
        let refreshControl = UIRefreshControl() //refresh
        refreshControl.addTarget(self, action: #selector(loadRealmStock), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    override func tableView(_ tableView : UITableView, commit editingStyle: UITableViewCell.EditingStyle , forRowAt indexPath: IndexPath) { //delete
        if editingStyle == .delete {
            let stock = stocksArray[indexPath.row]
            print("curr row\(indexPath.row)")
            
            stocksArray.remove(at: indexPath.row)
            deleteFromRealmDataBase(stock)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //loadRealmStock();
        }
    }
    
   
    
    
    @IBAction func addStock(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Get Stock Price?", message: "Type in the Symbol", preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            print("OK")
            guard let stockSymbol = self.globalStockTextField?.text?.uppercased() else {return}
            if stockSymbol == "" {
                return
            }
            //print("Current Symbol: \(stockSymbol)")
            self.symbolArray.append(stockSymbol)
            //print("Current Symbol Array: \(self.symbolArray)")
            self.getData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alertAction) in
            print ("Cancel")
        }
        
        alert.addTextField { (stockTextField) in
            stockTextField.placeholder = "Type Stock Symbol"
            self.globalStockTextField = stockTextField
        }
        
        alert.addAction(cancel)
        alert.addAction(OK)
        
        
        self.present(alert, animated: true, completion: nil) //!
    }
    

    
}

    

