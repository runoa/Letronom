//
//  AppDelegate.swift
//  Letronom
//
//  Created by Shohei Urano on 2015/06/06.
//  Copyright (c) 2015年 Shohei Urano. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let notification = Notification()
    let statusBar = StatusBar()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        notification.setNotifications()
        statusBar.setStatusItem()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}
