//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Manh Do on 12/21/16.
//  Copyright © 2016 DoApp. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
 
    func congifureCell(forecast: Forecast) {
        lowTempLabel.text = "\(forecast.lowTemp)"
        highTempLabel.text = "\(forecast.highTemp)"
        weatherStatusLabel.text = forecast.weatherStatus
        weatherIcon.image = UIImage(named: forecast.weatherStatus)
        dayLabel.text = forecast._date
    }
    
    
}
