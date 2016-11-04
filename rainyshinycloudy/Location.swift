//
//  Location.swift
//  rainyshinycloudy
//
//  Created by mudasar on 03/11/2016.
//  Copyright © 2016 appinvent.uk. All rights reserved.
//

import Foundation
import CoreLocation


class Location {

    static var sharedLocation = Location()
    
    private init() {}
    
    var lattitude: Double!
    var longitude: Double!
    
}
