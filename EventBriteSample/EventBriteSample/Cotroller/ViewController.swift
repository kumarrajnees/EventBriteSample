//
//  ViewController.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var reqestData:[String:Any] = [:]
        reqestData["lat"] =  49.279974
        reqestData["log"] = -123.11236500000001
        reqestData["start_date"] = "2019-08-27T00:00:01Z"
        reqestData["end_date"] = "2019-09-1T00:00:01Z"
        reqestData["radius"] = 2
        reqestData["page"] = 1

        APIService.getEvents(reqestData) { (sucees, erro) in
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }


}

