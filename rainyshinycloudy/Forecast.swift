//
//  Forecast.swift
//  rainyshinycloudy
//
//  Created by mudasar on 03/11/2016.
//  Copyright © 2016 appinvent.uk. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Forecast {
    var _date:String!
    var _weatherType: String!
    var _tempHigh: String!
    var _tempLow: String!
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType:String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var tempHigh: String {
        
        if _tempHigh == nil {
            _tempHigh = ""
        }
        
        return _tempHigh
    }
    
    var tempLow : String{
        
        if _tempLow == nil {
            _tempLow = ""
        }
        
        return _tempLow
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            if let min = temp["min"] as? Double {
                let kelvin_temp = min as Double
                let cel_temp =  kelvin_temp - 273.15
                self._tempLow = "\( round(cel_temp))"
            }
            
            if let max = temp["max"] as? Double {
                let kelvin_temp = max as Double
                let cel_temp =  kelvin_temp - 273.15
                self._tempHigh = "\( round(cel_temp))"
            }
        }
        
        if let dt = weatherDict["dt"] as? Double {
            // convert date in proper format
            let unixConvertedDate = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfWeek()
        }
        
        if let weatherList = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weatherList[0]["main"] as? String {
                self._weatherType = main
            }
        }
    }
    
}
