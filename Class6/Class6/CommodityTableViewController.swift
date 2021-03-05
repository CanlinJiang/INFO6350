//
//  CommodityTableViewController.swift
//  Class6
//
//  Created by little tree on 3/4/21.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON
import RealmSwift
import PromiseKit

class CommodityTableViewController: UITableViewController {
    @IBOutlet var tableCommodities: UITableView!
    var commoditiesArray: [Commodity] = [Commodity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCommodities()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commoditiesArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CommodityTableViewCell", owner: self, options: nil)?.first as! CommodityTableViewCell
        cell.labelName.text = commoditiesArray[indexPath.row].name
        cell.labelPrice.text = String(commoditiesArray[indexPath.row].price)

        return cell
    }
    
    func getCommodities() {
        let url = "https://financialmodelingprep.com/api/v3/quotes/commodity?apikey=3a7a859de20b5c1aa57316674e54b48d"
        getCommoditiesArray(url)
            .done {(commodities) in
                if commodities.count == 0 {
                    return
                }
                self.commoditiesArray = commodities;
                self.tableCommodities.reloadData()
                self.addToRealm(self.commoditiesArray)
            }
            .catch{(error) in
                print(error)
            }
    }
    func getCommoditiesArray(_ url: String) -> Promise<[Commodity]>{
        return Promise<[Commodity]> { seal -> Void in
            //SwiftSpinner.show("Loading data")
            AF.request(url).responseJSON { (response) in
                //SwiftSpinner.hide()
                if response.error == nil {
                    var commidities: [Commodity] = [Commodity]()
                    guard let dataRaw = response.data else {return seal.fulfill(commidities)}
                    guard let jsonArray = JSON(dataRaw).array else {return seal.fulfill(commidities)}
                    
                    for commodity in jsonArray {
                        let currCommodity = Commodity(commodity["name"].stringValue,commodity["price"].floatValue)
                        commidities.append(currCommodity)
                    }
                    seal.fulfill(commidities)
                } else {
                    seal.reject(response.error!)
                }
            }
        }
    }
    
    func addToRealm(_ commodities: [Commodity]) {
        do {
            let realm = try! Realm()
            try! realm.write {
                realm.add(commodities, update: .all)
            }
        } catch {
            print(error)
            }
            print(Realm.Configuration.defaultConfiguration.fileURL)
        }
    }


