//
//  TableViewController.swift
//  tableViewExample
//
//  Created by little tree on 3/24/21.
//

import UIKit

class TableViewController: UITableViewController {
    var arr: [WeatherCell] = [WeatherCell]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValues()
    }
    
    func initValues(){
        arr.append(WeatherCell("Monday", 88, 86, "5-s"))
        arr.append(WeatherCell("Tuesday", 88, 76, "13-s"))
        arr.append(WeatherCell("Wendesday", 99, 66, "1-s"))
        arr.append(WeatherCell("Thursday", 87, 76, "43-s"))
        arr.append(WeatherCell("Friday", 84, 66, "3-s"))
    }
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("WeatherTableViewCell", owner: self, options: nil)?.first as! WeatherTableViewCell
        cell.lblDayOfWeek.text = arr[indexPath.row].dayOfTheWeek
        cell.imageWeatherIcon.image = arr[indexPath.row].image
        cell.lblHigh.text = "H: \(arr[indexPath.row].maxTemp)℉"
        cell.lblLow.text = "L: \(arr[indexPath.row].minTemp)℉"
        
        return cell
    }
    


}
