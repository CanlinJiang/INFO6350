//
//  TableViewController.swift
//  Class4_Example3
//
//  Created by little tree on 2/17/21.
//

import UIKit

class TableViewController: UITableViewController {
    let cities = ["Atlanta", "Austin", "Baltimore", "Birmingham", "Boston", "Buffalo", "Charlotte", "Chicago", "Cincinnati", "Cleveland", "Columbus", "Dallas"]
    let temperatures = ["72", "80", "65", "74", "59", "56", "71", "59", "65", "60", "63", "77"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cities.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.labelCity.text = cities[indexPath.row]
        cell.labelTemperature.text = "\(temperatures[indexPath.row]) °F"

        return cell
    }
    

}
