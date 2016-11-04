//
//  WeatherTableViewCell.swift
//  rainyshinycloudy
//
//  Created by mudasar on 01/11/2016.
//  Copyright © 2016 appinvent.uk. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var dayWImage: UIImageView!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dayWeathetType: UILabel!
    @IBOutlet var dayWHigh: UILabel!
    @IBOutlet var dayWLow: UILabel!
    
    
    func updateData(forecast:Forecast) {
        dayLabel.text = forecast._date
        dayWeathetType.text = forecast.weatherType
        dayWHigh.text = forecast.tempHigh + "°"
        dayWLow.text = forecast.tempLow + "°"
        dayWImage.image = UIImage(named: forecast.weatherType)
    }
    
    
}
