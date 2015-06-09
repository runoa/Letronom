//
//  ViewController.swift
//  Letronom
//
//  Created by Shohei Urano on 2015/06/06.
//  Copyright (c) 2015年 Shohei Urano. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
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
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "refreshTimer", userInfo: nil, repeats: true)
    }
    
    func refreshTimer () {
        let calendar = NSCalendar.currentCalendar()
        let today = NSDate()
        let components = calendar.components(NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: today)
        var nextHour = components.hour + 1
        let minuteDiff = 60 - components.minute - 1
        let secondDiff = 60 - components.second
        if nextHour > 24 {
            nextHour = 0
        }
        statusItem.title = NSString(format: "%02d,%02d:%02d", nextHour, minuteDiff, secondDiff) as String
    }
    
    func setStatusItem () {
        let menu = NSMenu()
        statusItem.title = ""
        statusItem.highlightMode = true
        statusItem.menu = menu

        let menuTitle = NSMenuItem()
        menuTitle.title = "Letronom"
        menu.addItem(menuTitle)

        let menuQuit = NSMenuItem()
        menuQuit.title = "Quit"
        menuQuit.action = Selector("quit:")
        menu.addItem(menuQuit)
    }
    
    func quit (sender: NSButton) {
        NSApplication.sharedApplication().terminate(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setNotifications()
        self.setStatusItem()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

