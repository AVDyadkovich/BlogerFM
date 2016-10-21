//
//  AppDelegate.swift
//  BlogerFM-2
//
//  Created by Андрей on 20.10.16.
//  Copyright © 2016 Andy. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)

    @IBAction func quit(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let icon = NSImage(named:"status")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

