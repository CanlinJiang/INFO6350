//
//  waetherTableViewCell.swift
//  tableViewExample
//
//  Created by little tree on 3/24/21.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDayOfWeek: UILabel!
    @IBOutlet weak var imageWeatherIcon: UIImageView!
    @IBOutlet weak var lblHigh: UILabel!
    @IBOutlet weak var lblLow: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
