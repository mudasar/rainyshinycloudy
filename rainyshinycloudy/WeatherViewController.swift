//
//  ViewController.swift
//  rainyshinycloudy
//
//  Created by mudasar on 01/11/2016.
//  Copyright © 2016 appinvent.uk. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation


class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    var cw:CurrentWeather!
    var forecast:Forecast!
    var forecasts = [Forecast]()
    
    let locationManger = CLLocationManager()
    var currenctLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        //print(CURRENT_WEATHER_URL)
        cw = CurrentWeather()
        
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startMonitoringSignificantLocationChanges()
        
        
        locationAuthStatus()
        
        cw.downloadWeatherDetails {
            self.downloadForecast {
               self.updateMainUI()
                if self.forecasts.count > 0 {
                    self.forecasts.remove(at: 0)
                }
                self.tableView.reloadData()
            }
            
        }
    }
    
    func downloadForecast(completed: @escaping DownloadComplete) {
        //downlaod forecast data for table view
        let forecastUrl = URL(string: FORECAST_WEATHER_URL)
        Alamofire.request(forecastUrl!).responseJSON { (response) in
            let result = response.result
            if  let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                }
            }
           completed()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var currentWeatherImage: UIImageView!
    @IBOutlet var currentTempTypeLabel: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? WeatherTableViewCell {
            cell.updateData(forecast: forecasts[indexPath.row])
            return cell
        }else{
          return WeatherTableViewCell()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = cw.date
        currentTempLabel.text = "\(cw.currentTemp)°"
        locationLabel.text = cw.cityName
        currentTempTypeLabel.text = cw.weatherType
        currentWeatherImage.image = UIImage(named: cw.weatherType)
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
            currenctLocation = locationManger.location
            Location.sharedLocation.lattitude = currenctLocation.coordinate.latitude
            Location.sharedLocation.longitude = currenctLocation.coordinate.longitude
        }else{
            locationManger.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

}

