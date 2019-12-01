//
//  AppDelegate.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import UIKit
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //CoreLocationManager.sharedeInstance.configureLocationManager()
                MSAppCenter.start("75b28da3-0b2b-40e9-9685-8bcf89fe49a5", withServices:[
                    MSAnalytics.self,
                    MSCrashes.self
                    ])
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
enum GFDateFormat: String {
    case gmtDateFormate = "EEE MMM d HH:mm:ss 'GMT+05:30' yyyy"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"//"yyyy-MM-dd HH:mm:ss"
    case dayFullNameDateFormate = "EEEE"
    case dayDateFormate = "dd"
    case monthShortNameDateFormate = "MMM"
    case monthDateFormate = "MM"
    case yearDateFormate = "yyyy"
    case HHmm = "HH:mm"
    case yyyyMMdd = "yyyy-MM-dd'T'HH:mm:ss.000Z"
    case mmddyy = "MM/dd/yyyy"
}

extension Date {
    // Returns the number of years
    func yearsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    // Returns the number of months
    func monthsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    // Returns the number of weeks
    func weeksCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    // Returns the number of days
    func daysCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    // Returns the number of hours
    func hoursCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    // Returns the number of minutes
    func minutesCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    // Returns the number of seconds
    func secondsCount(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    // Returns time ago by checking if the time differences between
    //two dates are in year or months or weeks or days or hours or minutes or seconds
    func timeAgo(from date: Date) -> String {
        let yearCount = yearsCount(from: date)
        let monthCount = monthsCount(from: date)
        let weekCount = weeksCount(from: date)
        let dayCount = daysCount(from: date)
        let hourCount = hoursCount(from: date)
        let minuteCount = minutesCount(from: date)
        let secCount = secondsCount(from: date)
        if  yearCount  > 0 { return "\(yearCount) year" + (yearCount > 1 ? "s":"") + " ago"   }
        if monthCount  > 0 { return "\(monthCount) month" + (monthCount > 1 ? "s":"") + " ago"  }
        if weekCount   > 0 { return "\(weekCount) week" + (weekCount > 1 ? "s":"") + " ago"   }
        if dayCount    > 0 { return "\(dayCount) day" + (dayCount > 1 ? "s":"") + " ago"    }
        if hourCount   > 0 { return "\(hourCount) hour" + (hourCount > 1 ? "s":"") + " ago"   }
        if minuteCount > 0 { return "\(minuteCount) minute" + (minuteCount > 1 ? "s":"") + " ago" }
        if secCount > 0 { return "\(secCount) second" + (secCount > 1 ? "s":"") + " ago" }
        //return "test"
        return "1 second ago"
    }
    /// Calculate time from now
    func timeAgo(from dateStr: String, dateFormat format: GFDateFormat) -> String? {
        if let date = GFDateUtil.date(date: dateStr, dateFormat: format) {
            return timeAgo(from: date)
        }
        return nil
    }
    /// get current date in given formate
    ///
    /// - Parameter format: date formate
    /// - Returns: return date in string
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

/// Has all date related helper methods.
class GFDateUtil {
    static let dateFormatter = DateFormatter()
    // MARK: - Public Methods
    ///Return the Date instanse for the given date string.
    ///
    /// - Parameters:
    ///   - date: date to change formate.
    ///   - dateFormat: new date formate.
    static func date(date: String, dateFormat: GFDateFormat) -> Date? {
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.date(from: date)
    }
    ///Return the string instanse for the given date.
    ///
    /// - Parameters:
    ///   - date: date.
    ///   - format: date formate in which you want date.
    static func string(date: Date, dateFormat: GFDateFormat) -> String {
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: date)
    }
    static func serverToLocal(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: date)
        let dateStr = GFDateUtil.string(date: localDate ?? Date(), dateFormat: GFDateFormat.yyyyMMddHHmmss)
        return dateStr
    }
    ///Return the date instance with new date formate.
    ///
    /// - Parameters:
    ///   - date: date to convert formate.
    ///   - currentFormate: current date formate.
    ///   - newFormate: date formate in which you want converted date.
    static func convertDateFormate(date: Date, currentFormate: GFDateFormat, newFormate: GFDateFormat) -> Date? {
        let dateStr = self.string(date: date, dateFormat: currentFormate)
        let newDate = self.date(date: dateStr, dateFormat: newFormate)
        return newDate
    }
    ///Return the Day name for the date.
    ///
    /// - Parameters:
    ///   - date: Date class instance.
    static func dayName(date: Date) -> String {
        return string(date: date, dateFormat: GFDateFormat.dayFullNameDateFormate)
    }
    ///Return the Day for the date.
    ///
    /// - Parameters:
    ///   - date: Date class instance.
    static func day(date: Date) -> String {
        return string(date: date, dateFormat: GFDateFormat.dayDateFormate)
    }
    ///Return the Month name in short formate like "Dec for December" name for the date.
    ///
    /// - Parameters:
    ///   - date: Date class instance.
    static func monthName(date: Date) -> String {
        return string(date: date, dateFormat: GFDateFormat.monthShortNameDateFormate)
    }
    ///Return the Month.
    ///
    /// - Parameters:
    ///   - date: Date class instance.
    static func month(date: Date) -> String {
        return string(date: date, dateFormat: GFDateFormat.monthDateFormate)
    }
    ///Return the Year for the date.
    ///
    /// - Parameters:
    ///   - date: Date class instance.
    static func year(date: Date) -> String {
        return string(date: date, dateFormat: GFDateFormat.yearDateFormate)
    }
}
