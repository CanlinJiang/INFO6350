//
//  TableViewController.swift
//  Class4_Example3
//
//  Created by little tree on 2/17/21.
//

import UIKit

class TableViewController: UITableViewController {
    let stocks = ["aaa", "ff", "gg", "gggs", "asdf", "gads"]
    let values = ["1", "3", "2", "5", "2", "5"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stocks.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.labelStock.text = stocks[indexPath.row]
        cell.labelValue.text = "$ \(values[indexPath.row])"

        return cell
    }
    

}
