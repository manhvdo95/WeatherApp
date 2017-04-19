//
//  Forecast.swift
//  WeatherApp
//
//  Created by Manh Do on 12/21/16.
//  Copyright © 2016 DoApp. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {

    var _date: String!
    var _weatherStatus: String!
    var _highTemp: Double!
    var _lowTemp: Double!
    
    var date: String {
        return _date
    }
    
    var weatherStatus: String {
        return _weatherStatus
    }
    
    var highTemp: Double {
        return _highTemp
    }
    
    var lowTemp: Double {
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                
                let kelvinToFarenheit = (min * 9 / 5) - 459.67
                let kelvinToFarenheitRounded = Double(round(10 * kelvinToFarenheit) / 10)
                self._lowTemp = kelvinToFarenheitRounded
                
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToFarenheit = (max * 9 / 5) - 459.67
                let kelvinToFarenheitRounded = Double(round(10 * kelvinToFarenheit) / 10)
                self._highTemp = kelvinToFarenheitRounded
                
            }

        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherStatus = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // more info in format here http://nsdateformatter.com/
        
        return dateFormatter.string(from: self)
    }
    
}





















