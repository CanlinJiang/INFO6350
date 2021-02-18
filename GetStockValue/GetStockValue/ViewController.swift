//
//  ViewController.swift
//  GetStockValue
//
//  Created by little tree on 2/17/21.
//

import UIKit

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
            guard let stockSymbol = self.globalStockTextField?.text else {return}
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
    
    func getStockValue(_ stockSymbol : String) -> String{
        print(getURL(stockSymbol))
        return ""
    }
    
    func getURL(_ stockSymbol : String) -> String {
        let url = apiURL + stockSymbol + "?apikey=" + apiKey
        return url
    }
    
}

