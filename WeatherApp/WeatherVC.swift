//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Manh Do on 12/19/16.
//  Copyright © 2016 DoApp. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherStatus: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    
    var forecastArray = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // number of section, essentially act as columns
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // number of rows or cell in the tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    // Setting up the "weatherCell" to be reuseable for each index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
        
            let forecast = forecastArray[indexPath.row]
            cell.congifureCell(forecast: forecast)
            return cell
            
        }
        else {
            return WeatherCell()
        }
        
        
    }
    
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherStatus.text = currentWeather.weatherStatus
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherStatus)
        
    }
    
    
    func downloadForecastData(completed: DownloadComplete) {
        Alamofire.request(FORECAST_URL).responseJSON { response in
        
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forcast = Forecast(weatherDict: obj)
                        self.forecastArray.append(forcast)
                        //print(obj)
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        completed()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherData {
                self.downloadForecastData {
                    self.updateMainUI()
                }
            }
        }
            
        else {
            // User dont allow permission
            //TODO: direct user to Settings using UIApplicationOpenSettingsURLString
        }
        
    }

}













