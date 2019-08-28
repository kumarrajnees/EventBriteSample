//
//  Constants.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
let auth_token = "SLYUSHGGF325WN5VE56L"
let dateFormat = "yyyy-MM-dd"
class Utility {
    class func changeStringToDateInFormat(_ dateString : String , formatString : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        dateFormatter.timeZone =  TimeZone.init(abbreviation: "GMT")!
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    class func changeDateInFormat(_ date : Date , formatString : String) ->String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone =  TimeZone.init(abbreviation: "UTC")!
        dateFormatter.dateFormat = formatString
        return dateFormatter.string(from: date)
    }
    class func getEndEventDate() -> String {
        if let nextDate = Calendar.current.date(byAdding: .day, value: 7, to: Date()) {
            return changeDateInFormat(nextDate, formatString: dateFormat)
        }
        return ""
    }
}

