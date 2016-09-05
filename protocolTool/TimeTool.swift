//
//  TimeTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/3/16.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

enum MonthType {
    case MonthTypeLast;
    case MonthTypeNext;
}

class TimeTool: NSObject {
    /**
     获取当前日期和当前时间
     */
    static func getCurrentDateAndTime() -> (currentDate: String, currentTime: String) {
        let date = NSDate()
        let formater = NSDateFormatter()
        formater.timeZone = NSTimeZone.systemTimeZone()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formater.stringFromDate(date) as NSString
        let currentDate = dateString.substringWithRange(NSMakeRange(0, 10))
        let currentTime = dateString.substringWithRange(NSMakeRange(11, 5))
        return (currentDate, currentTime)
    }
    
    /**
     获取当前是周几、当前日期、当前时间
     */
    static func getCurrentWeekday() -> String {
        return getWeekdaySomeday(NSDate())
    }
    
    /**
     获取某一个日期是周几
     */
    static func getWeekdaySomeday(someDay: NSDate) -> String {
        let calender = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let unitFlags: NSCalendarUnit = NSCalendarUnit.Weekday
        let comps = (calender?.components(unitFlags, fromDate: someDay))!
        let week = comps.weekday
        
        let arrWeek = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
        // 当前是周几
        let currentWeekday = arrWeek[week - 1]
        return currentWeekday
    }
    
    /**
     从服务器返回的时间字符串中截取时、分
     */
    static func timeSubString(timeString: NSString) -> String {
        return timeString.substringWithRange(NSMakeRange(11, 5))
    }
    
    
    /**
     传入日期   获得距离该日期的上一个月的日期或者下一个月的日期
     */
    static func getLastMonthSomeDayOrNextMonthSomeDay(oldDateString: String, type: MonthType) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.dateFromString(oldDateString)
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let calendarUnit: NSCalendarUnit = [NSCalendarUnit.Year ,NSCalendarUnit.Month]
        calendar?.component(calendarUnit, fromDate: date!)
        let adcomps = NSDateComponents()
        
        let currentMonth = (oldDateString as NSString).substringWithRange(NSMakeRange(5, 2))
        if type == MonthType.MonthTypeNext { // 下一月
            if Int(currentMonth) == 12 {
                adcomps.year = 1
            }
            adcomps.month = 1
        } else {
            if Int(currentMonth) == 1 {
                adcomps.year = -1
            }
            adcomps.month = -1
        }
        
        let newdate = calendar?.dateByAddingComponents(adcomps, toDate: date!, options: NSCalendarOptions.WrapComponents)
        let dateString = formatter.stringFromDate(newdate!)
        let newDate = dateString.substringToIndex(dateString.startIndex.advancedBy(10))
        return newDate
    }
}
