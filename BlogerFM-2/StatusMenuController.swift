//
//  StatusMenuController.swift
//  BlogerFM-2
//
//  Created by Андрей on 21.10.16.
//  Copyright © 2016 Andy. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
   
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var volumeBarOutlet: NSSlider!
    var volumeBarMenu:NSMenuItem!

    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    override func awakeFromNib() {
  
        let icon = NSImage(named:"status")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
        volumeBarMenu = statusMenu.item(withTitle: "volumeBar")
        volumeBarMenu.view = volumeBarOutlet
        blogerFM.play()
        blogerFM.volume = volumeBarOutlet.floatValue
    }
    
    @IBAction func volumeBar(_ sender: NSSlider) {
        
        blogerFM.volume = volumeBarOutlet.floatValue
    }
    
    @IBAction func quit(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }


}
