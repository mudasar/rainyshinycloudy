//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by mudasar on 01/11/2016.
//  Copyright © 2016 appinvent.uk. All rights reserved.
//


import UIKit
import Alamofire

class CurrentWeather{
    var _cityName:String!
    var _date:String!
    var _weatherType: String!
    var _currentTemp: Double!
  
    
    var cityName:String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType:String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        
        return _currentTemp
    }
    

    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        let currentWeatherUrl = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherUrl).responseJSON { (response) in
            let result = response.result
        
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self.cityName)
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main
                        print(self.weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double{
                        let kelvin_temp = temp as Double
                        let cel_temp =  kelvin_temp - 273.15
                        self._currentTemp = round(cel_temp)
                    }
                }
            }
            
            
          //  print(result)
//            
//        
            if let JSON = response.result.value {
                
                print("JSON: \(JSON)")
            }
            
            completed()
        
        }
        
    }
    
    
}
