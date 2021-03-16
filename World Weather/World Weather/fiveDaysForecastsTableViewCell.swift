//
//  fiveDaysForecastsTableViewCell.swift
//  World Weather
//
//  Created by little tree on 3/11/21.
//

import UIKit

class fiveDaysForecastsTableViewCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var highTemperature: UILabel!
    @IBOutlet weak var lowTemperature: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
