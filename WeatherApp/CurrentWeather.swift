//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Manh Do on 12/19/16.
//  Copyright © 2016 DoApp. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _weatherStatus: String!
    var _currentTemp: Double!
    
    var cityName: String {
        return _cityName
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        _date = "\(currentDate)"
        
        return _date
    }
    
    var weatherStatus: String {
        return _weatherStatus
    }
    
    var currentTemp: Double {
        return _currentTemp
    }
    
    
    // Alamofire download
    func downloadWeatherData(completed: @escaping DownloadComplete) {
        
        // GET request from weather URL using Alamofire in JSON format
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in

            let result = response.result
            //print(response)
            
            // parsing data
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherStatus = main.capitalized
                        print(self._weatherStatus)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let temp = main["temp"] as? Double {
                        let kelvinToFarenheit = (temp * 9 / 5) - 459.67
                        
                        let kelvinToFarenheitRounded = Double(round(10 * kelvinToFarenheit) / 10)
                        self._currentTemp = kelvinToFarenheitRounded
                        print(self._currentTemp)
                    }
                    
                }
                
            }
            completed()
            
        }
        
        
    }
    
    
}
