//
//  StatusMenuController.swift
//  BlogerFM-2
//
//  Created by Андрей on 21.10.16.
//  Copyright © 2016 Andy. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
   // Initializing Outlets, Menus, Values
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
       // if blogerFM.status == .failed {
       //     print(blogerFM.error ?? "Error")
       // } else{
       //     blogerFM.play()
       // }
       
        if UserDefaults.standard.float(forKey: "volume") != 0 {
        volumeBarOutlet.floatValue = UserDefaults.standard.float(forKey: "volume")
        }
        blogerFM.volume = volumeBarOutlet.floatValue
        playPauseMenu = statusMenu.item(withTitle: "PlayPauseBar")
        playPauseMenu.view = playPauseOutlet
        blogerFM.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        blogerFM.currentItem?.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
        blogerFM.currentItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
       
    }
    
    @IBAction func volumeBar(_ sender: NSSlider) {
        blogerFM.volume = volumeBarOutlet.floatValue
    }
    
    @IBAction func playPauseButton(_ sender: NSButton) {
        
        switch sender.state {
        case 1:
            let imgBut:NSImage? = NSImage(named: "Pause")
            sender.image = imgBut
            blogerFM.volume = volumeBarOutlet.floatValue
            blogerFM.replaceCurrentItem(with: blogerPlayerItem)
            blogerFM.play()
        case 0:
            let altImgBt:NSImage? = NSImage(named: "Play")
            sender.image = altImgBt
            blogerFM.replaceCurrentItem(with: nil)
            //blogerFM.volume = 0.0
        default: break
        }
        
    }
    
    
    @IBAction func quit(_ sender: NSMenuItem) {
        UserDefaults.standard.set(blogerFM.volume, forKey: "volume")
        NSApplication.shared().terminate(self)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath != nil else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        switch keyPath! {
        case "playbackBufferEmpty" :
            if blogerFM.currentItem!.isPlaybackBufferEmpty {
                print("no buffer")
            }
        case "playbackLikelyToKeepUp" :
            if blogerFM.currentItem!.isPlaybackLikelyToKeepUp {
                print("resume Play")
            }
        case "status" :
            print (change!)
            print(blogerFM.currentItem?.status.rawValue ?? 3)
        default:
            print ("test")
        }
    }
    deinit {
        self.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        self.removeObserver(self, forKeyPath: "playbackLikelyToKeepUp")
        self.removeObserver(self, forKeyPath: "status")
    }

}
