//
//  ViewController.swift
//  GetStockValue
//
//  Created by little tree on 2/17/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController {
    @IBOutlet weak var stockPrice: UILabel!
    var globalStockTextField : UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getStockAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Get Stock Price?", message: "Type in the Symbol", preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            print("OK")
            guard let stockSymbol = self.globalStockTextField?.text?.uppercased() else {return}
            if stockSymbol == "" {
                return self.stockPrice.text = "No Stock Symbol"
            }
            self.getStockValue(stockSymbol)
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
    
    func getStockValue(_ stockSymbol : String) {
        let url = getURL(stockSymbol)
        print(url)
        SwiftSpinner.show("Getting \(stockSymbol) Stock Value")
        
        AF.request(url).responseJSON { response in
            SwiftSpinner.hide()
            
            if response.error == nil {
                let stockData: JSON = JSON(response.data!)
                
                guard let stocks = stockData.array else {return}
                
                if stocks.count != 0 {
                    for stock in stocks {
                        self.stockPrice.text = "\(stock["symbol"]): $\(stock["price"])"
                        print(stock["symbol"])
                        print(stock["price"])
                    }
                    print(stockData)
                } else {
                    self.stockPrice.text = "Stock symbol \(stockSymbol) does not exists. "
                }
                
            } else {
                print(response.error?.localizedDescription)
                }
        }
       
    }
    
    func getURL(_ stockSymbol : String) -> String {
        let url : String = apiURL + stockSymbol + "?apikey=" + apiKey
        
        return url
    }
    
}

