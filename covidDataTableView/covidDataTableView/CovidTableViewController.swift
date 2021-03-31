//
//  CovidTableViewController.swift
//  covidDataTableView
//
//  Created by little tree on 3/30/21.
//

import UIKit

class CovidTableViewController: UITableViewController {
    @IBOutlet var tblView: UITableView!
    var covidArray: [Covid] = [Covid]();
    let viewModel = CovidTableViewModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCovidData();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return covidArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CovidTableViewCell", owner: self, options: nil)?.first as! CovidTableViewCell
        
        cell.lblState.text = self.covidArray[indexPath.row].state;
        cell.lblTotal.text = "\(self.covidArray[indexPath.row].total)";
        cell.lblPositive.text = "\(self.covidArray[indexPath.row].positive)";
        
        return cell
    }
    
    func updateCovidData() {
        self.covidArray.removeAll()
        viewModel.getCurrentConditions(url).done { covidArrayData in
            for covid in covidArrayData {
                self.covidArray.append(covid)
            }
            self.tblView.reloadData();
        }.catch { error in
            print("Error in getting covid data")
        }
        
        
    }

}
