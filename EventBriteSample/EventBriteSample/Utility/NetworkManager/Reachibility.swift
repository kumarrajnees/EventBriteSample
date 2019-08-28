//
//  Reachibility.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation
import Network

class Reachibility {
    let monitor = NWPathMonitor()
    var isNetworkAvailable = false
    static let sharedInstance: Reachibility = {
        let instance = Reachibility()
        return instance
    }()
 
    func checkNetworkStatus() {
        monitor.pathUpdateHandler = { [weak self] (status) in
            if status.status == .satisfied {
                self?.isNetworkAvailable = true
            } else {
                self?.isNetworkAvailable = true
            }
        }
    }
}
