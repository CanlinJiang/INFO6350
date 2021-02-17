//
//  TableViewController.swift
//  Class4_example
//
//  Created by little tree on 2/16/21.
//

import UIKit

class TableViewController: UITableViewController {
    

    let cities = ["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "e", "f", "g", "h"]

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
        
        return cell
    }
    

    

}
