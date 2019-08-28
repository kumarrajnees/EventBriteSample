//
//  APIService.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService {
    
    class func getEvents(_ reqestData:[String:Any], completion : @escaping (_ isSuccess : Bool, _ error :HNError?,_ data:JSON?) ->Void) {
        
        let lat = reqestData["lat"] as! Double
        let log = reqestData["log"] as! Double
        let startDate = reqestData["start_date"] as! String
        let endDate = reqestData["end_date"] as! String
        let radiusInMiles = reqestData["radius"] as! Int
        let pageNumer = reqestData["page"] as! Int

        let eventURL = "https://www.eventbriteapi.com/v3/events/search/?location.longitude=\(log)&location.latitude=\(lat)&expand=venue&date_modified.range_start=\(startDate)&date_modified.range_end=\(endDate)&location.within=\(radiusInMiles)mi&page=\(pageNumer)"
        let headers: [String: String] = ["Authorization": "Bearer \(auth_token)"]
        APIManager.request(urlString: eventURL, requestMethod: .get, headers: headers, params: nil, success: { (response) in
            print(response)
            
            
            let model = JSON.init(response)
            completion(true,nil,model)

            
//            do {
//                //1. Convert JSONObject to Data
//                let data = try JSONSerialization.data(
//                withJSONObject: response,
//                options: JSONSerialization.WritingOptions.prettyPrinted)
//                //2. try to parse data to associated model
//                let model = try JSONDecoder().decode(BriteEvents.self, from: data)
//                completion(true,nil,model)
//            } catch {
//                completion(false,nil,nil)
//            }
            
        }) { (error) in
            print(error)
            completion(false,nil,nil)
        }
    }
    
}
