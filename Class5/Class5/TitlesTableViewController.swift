//
//  TitlesTableViewController.swift
//  Class5
//
//  Created by little tree on 3/3/21.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON

class TitlesTableViewController: UITableViewController {
    
    var titileArray : [String] = [String]()
    @IBOutlet var titlesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        getTitiles()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titileArray.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TitleTableViewCell", owner: self, options: nil)?.first as! TitleTableViewCell
        cell.titleLabel.text = self.titileArray[indexPath.row]

        return cell
    }
    
    func getTitiles() {
        let url: String = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2c200f488e264b138c48bd28ab904b43"
        
        //SwiftSpinner.show("Getting News Titiles")
        AF.request(url).responseJSON { (response) in
            //SwiftSpinner.hide()
            if response.error == nil{
                
                guard let responseData = response.data else{return}
                let responseJson: JSON = JSON(responseData)
                guard let articles = responseJson["articles"].array else {return}
                if articles.count != 0 {
                    for article in articles {
                        self.titileArray.append(article["title"].stringValue)
                    }
                } else {
                    print("No Articles' value")
                }
                
                
            } else {
                print(response.error?.localizedDescription)
            }
            self.titlesTableView.reloadData()//!
            print("HEREE \(self.titileArray.count)")
        }
        
    }
}
