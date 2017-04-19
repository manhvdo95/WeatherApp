//
//  Location.swift
//  WeatherApp
//
//  Created by Manh Do on 12/21/16.
//  Copyright © 2016 DoApp. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    
    private init() {
        
    }
    
    var latitude: Double!
    var longitude: Double!
    
}
