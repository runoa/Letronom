//
//  ViewController.swift
//  Letronom
//
//  Created by Shohei Urano on 2015/06/06.
//  Copyright (c) 2015年 Shohei Urano. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

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
    
    func getAdditionalTitle () -> String {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.stringFromDate(NSDate())
    }
    
    func setNotification () {
        let nextTime = self.getNextTime()
        NSLog("add new notification: %@", nextTime);
        let notification = NSUserNotification()
        notification.title = "Title"
        notification.informativeText = "Text"
        notification.deliveryDate = nextTime
        NSUserNotificationCenter.defaultUserNotificationCenter().scheduleNotification(notification)
    }
    
    func setNotifications () {
        self.setNotification()
        NSTimer.scheduledTimerWithTimeInterval(60 * 60, target: self, selector: "setNotification", userInfo: nil, repeats: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setNotifications()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

