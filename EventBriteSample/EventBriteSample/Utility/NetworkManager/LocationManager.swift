//
//  LocationManager.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation
import CoreLocation

/// A manager class used for location and speed when a new ride start
class CoreLocationManager: NSObject {
    static let sharedeInstance = CoreLocationManager()
    var locationManager : CLLocationManager = CLLocationManager()
    var previousLocation : CLLocation?
    var lastNonZeroSpeed : Float = 0.0
    var gpsValueUpdates : ((_ lat: Double, _ log: Double)->(Void))?
    var isGPSEnabled = false
    private override init(){}
    
    /// Configuration of CLLocationManager configuration
    func configureLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 2000 // 2km
        locationManager.activityType = .fitness
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startUpdatingLocation()
    }
    /// To Stop the location update when ride get stoped
    func stopLocationManager() {
        locationManager.stopUpdatingLocation()
        previousLocation = nil
        lastNonZeroSpeed = 0.0
    }
    
    func getdistance(location1:CLLocationCoordinate2D,location2:CLLocationCoordinate2D) -> Double {
        let coordinate1 = CLLocation(latitude: location1.latitude, longitude: location1.longitude)
        let coordinate2 = CLLocation(latitude: location2.latitude, longitude: location2.longitude)
        return coordinate1.distance(from: coordinate2) // result is in meters
    }
}

// MARK: - CLLocationManagerDelegate
extension CoreLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let currentLocation = locations.last {
            print(currentLocation.coordinate)
            gpsValueUpdates?(currentLocation.coordinate.latitude,currentLocation.coordinate.longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            CoreLocationManager.sharedeInstance.isGPSEnabled =  false
            CoreLocationManager.sharedeInstance.stopLocationManager()
            // The user denied authorization
        } else {
            // The user accepted authorization
            CoreLocationManager.sharedeInstance.isGPSEnabled =  true
            //CoreLocationManager.sharedeInstance.configureLocationManager()
        }
    }
}

