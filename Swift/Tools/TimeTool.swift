//
//  TimeTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/3/16.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

class TimeTool {
    /**
     获取当前日期和当前时间
     */
    static func getCurrentDateAndTime() -> (currentDate: String, currentTime: String) {
        let date = Date()
        let formater = DateFormatter()
        formater.timeZone = NSTimeZone.system
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formater.string(from: date) as NSString
        let currentDate = dateString.substring(with: NSMakeRange(0, 10))
        let currentTime = dateString.substring(with: NSMakeRange(11, 5))
        return (currentDate, currentTime)
    }
    
    /**
     获取当前是周几、当前日期、当前时间
     */
    static func getCurrentWeekday() -> String {
        return getWeekdaySomeday(someDay: Date())
    }
    
    /**
     获取某一个日期是周几
     */
    static func getWeekdaySomeday(someDay: Date) -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        let unitFlags: NSCalendar.Unit = NSCalendar.Unit.weekday
        let comps = (calender?.components(unitFlags, from: someDay))!
        guard let week = comps.weekday else { return "" }
        let arrWeek = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
        // 当前是周几
        let currentWeekday = arrWeek[week - 1]
        return currentWeekday
    }
    
    /**
     从服务器返回的时间字符串中截取时、分
     */
    static func timeSubString(timeString: NSString) -> String {
        return timeString.substring(with: NSMakeRange(11, 5))
    }
}
