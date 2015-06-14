//
//  Notification.swift
//  Letronom
//
//  Created by Shohei Urano on 2015/06/10.
//  Copyright (c) 2015年 Shohei Urano. All rights reserved.
//

import Cocoa

class Notification: NSObject {
    func getNextTime () -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let today = NSDate()
        let components = calendar.components(NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: today)
        let minuteDiff = 60 - components.minute - 1
        let secondDiff = 60 - components.second
        var nextTime: NSDate! = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitMinute, value: minuteDiff, toDate: today, options: nil)
        nextTime = calendar.dateByAddingUnit(NSCalendarUnit.CalendarUnitSecond, value: secondDiff, toDate: nextTime, options: nil)
        return nextTime!
    }
    
    func getNextTimeText (date: NSDate) -> String {
        var date_formatter = NSDateFormatter()
        date_formatter.locale = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "HH時です / MM月dd日"
        NSLog("%@",  date_formatter.stringFromDate(date))
        return date_formatter.stringFromDate(date)
    }

    func setNotification () {
        let nextTime = self.getNextTime()
        NSLog("add new notification: %@", nextTime);
        let notification = NSUserNotification()
        notification.title = "Letronom"
        notification.informativeText = self.getNextTimeText(nextTime)
        notification.deliveryDate = nextTime
        NSUserNotificationCenter.defaultUserNotificationCenter().scheduleNotification(notification)
    }
    
    func setNotifications () {
        self.setNotification()
        NSTimer.scheduledTimerWithTimeInterval(60 * 60, target: self, selector: "setNotification", userInfo: nil, repeats: true)
    }
}
