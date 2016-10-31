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
    @IBOutlet weak var playPauseOutlet: NSView!
    @IBOutlet weak var playPauseButtonOutlet: NSButtonCell!
    
    var volumeBarMenu:NSMenuItem!
    var playPauseMenu:NSMenuItem!

    
    
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
        playPauseMenu = statusMenu.item(withTitle: "PlayPauseBar")
        playPauseMenu.view = playPauseOutlet
        
    }
    
    @IBAction func volumeBar(_ sender: NSSlider) {
        blogerFM.volume = volumeBarOutlet.floatValue
    }
    
    @IBAction func playPauseButton(_ sender: NSButton) {
        if sender.state == 1 {
            let imgBut:NSImage? = NSImage(named: "Play")
            sender.image = imgBut
            blogerFM.play()
        }else{
            let altImgBt:NSImage? = NSImage(named: "Pause")
            sender.image = altImgBt
            blogerFM.rate = 0.0
        }
    }
    
    
    @IBAction func quit(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }


}
