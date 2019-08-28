//
//  EventBriteViewModel.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation

struct EventViewModel {
    var latitude:Double = 0
    var logitude:Double = 0
    
    init() {
        let locationManager =  CoreLocationManager.sharedeInstance
        locationManager.gpsValueUpdates = { (lat,log) in
           // self.updateValue(lat: lat, log: log)
        }
    }
    
    mutating func updateValue(lat:Double,log:Double) {
        latitude = lat
        logitude = log
    }
}
