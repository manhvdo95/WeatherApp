//
//  Constants.swift
//  WeatherApp
//
//  Created by Manh Do on 12/19/16.
//  Copyright © 2016 DoApp. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let CURRENT_WEATHER = "weather?"
let FORCAST_WEATHER = "/forecast/daily?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let FORCAST_EXTRA = "&cnt=10&mode=json"
let API_KEY = "ADD OPENWEATHERMAP API KEY HERE"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(CURRENT_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(BASE_URL)\(FORCAST_WEATHER)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(FORCAST_EXTRA)\(APP_ID)\(API_KEY)"


