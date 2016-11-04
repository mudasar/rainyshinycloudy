//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by mudasar on 01/11/2016.
//  Copyright © 2016 appinvent.uk. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"
let WEATHER_API_CALL = "weather?"
let LATTITUDE = "lat=\(Location.sharedLocation.lattitude!)"
let LONGITUDE = "&lon=\(Location.sharedLocation.longitude!)"
let API_KEY = "&appid=0e372f70724e35517b20becc4b1c23a2"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(WEATHER_API_CALL)\(LATTITUDE)\(LONGITUDE)\(API_KEY)"
let FORECAST_API_CALL = "forecast/daily?"
let API_MODE = "&mode=json"
let API_RESULT_COUNT = "&cnt=10"

let FORECAST_WEATHER_URL = "\(BASE_URL)\(FORECAST_API_CALL)\(LATTITUDE)\(LONGITUDE)\(API_RESULT_COUNT)\(API_MODE)\(API_KEY)"

typealias DownloadComplete = () -> ()

extension Date{
    func dayOfWeek() -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEE"
        return dayFormatter.string(from: self)
    }
}
