//
//  ExtensionTableView.swift
//  GetStockValue
//
//  Created by little tree on 3/4/21.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON
import RealmSwift


extension StockTableViewController{
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
    
    
}
