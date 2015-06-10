//
//  StatusBar.swift
//  Letronom
//
//  Created by Shohei Urano on 2015/06/10.
//  Copyright (c) 2015年 Shohei Urano. All rights reserved.
//

import Cocoa

class StatusBar: NSObject {
    
    var statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

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

    func quit (sender: NSButton) {
        NSApplication.sharedApplication().terminate(self)
    }

    func setStatusItem () {
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "refreshTimer", userInfo: nil, repeats: true)

        let menu = NSMenu()
        statusItem.title = ""
        statusItem.highlightMode = true
        statusItem.menu = menu
        
        let menuTitle = NSMenuItem()
        menuTitle.title = "Letronom"
        menu.addItem(menuTitle)
        
        let menuQuit = NSMenuItem()
        menuQuit.title = "Quit"
        menuQuit.target = self
        menuQuit.action = Selector("quit:")
        menu.addItem(menuQuit)
    }

}
