//
//  StatusMenuController.swift
//  BlogerFM-2
//
//  Created by Андрей on 21.10.16.
//  Copyright © 2016 Andy. All rights reserved.
//

import Cocoa
import AVFoundation

class StatusMenuController: NSObject{
   // Initializing Outlets, Menus, Values
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var volumeBarOutlet: NSSlider!
    @IBOutlet weak var playPauseOutlet: NSView!
    @IBOutlet weak var playPauseButtonOutlet: NSButtonCell!
    @IBOutlet weak var muteButtonOutlet: NSButton!
    
    var volumeBarMenu:NSMenuItem!
    var playPauseMenu:NSMenuItem!
    var preferencesWindow: PreferencesWindowController!
    var titleMenu: NSMenuItem!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    //end Initialization block.
    
    override func awakeFromNib() {
        // Initializing and configuring app.
        if UserDefaults.standard.string(forKey: "rate") == nil{
            UserDefaults.standard.set(128, forKey:"rate")
        }
        let icon = NSImage(named:NSImage.Name(rawValue: "status"))
        icon?.isTemplate = true
        preferencesWindow = PreferencesWindowController()
        statusItem.image = icon
        statusItem.menu = statusMenu
        volumeBarMenu = statusMenu.item(withTitle: "volumeBar")
        volumeBarMenu.view = volumeBarOutlet
        blogerFM.currentItem?.canUseNetworkResourcesForLiveStreamingWhilePaused = true
        blogerFM.play()
        
        //Volume bar and current status.
        if UserDefaults.standard.float(forKey: "volume") != 0 {
        volumeBarOutlet.floatValue = UserDefaults.standard.float(forKey: "volume")
        }
        blogerFM.volume = volumeBarOutlet.floatValue
        playPauseMenu = statusMenu.item(withTitle: "PlayPauseBar")
        playPauseMenu.view = playPauseOutlet
       
        addBlogerObservers() // Adding observers
        
    }
    // Initializing volume bar.
    @IBAction func volumeBar(_ sender: NSSlider) {
            if muteButtonOutlet.state.rawValue == 1 {
                let imgBut:NSImage? = NSImage(named: NSImage.Name(rawValue: "UnMute"))
                muteButtonOutlet.image = imgBut
                muteButtonOutlet.state = NSControl.StateValue(rawValue: 0)
            }
        blogerFM.volume = volumeBarOutlet.floatValue
        changeMute()
    }
    // Change Mute method.
    func changeMute () {
        if blogerFM.volume == 0.0{
            let imgBut:NSImage? = NSImage(named: NSImage.Name(rawValue: "Mute"))
            muteButtonOutlet.image = imgBut
            muteButtonOutlet.state = NSControl.StateValue(rawValue: 1)
        }
    }
    
    // Showing current title by button.
    @IBAction func CurrentTitle(_ sender: Any) {
        NSUserNotificationCenter.default.deliver(notification)
     
    }
    
    @IBAction func playPauseButton(_ sender: NSButton) {
        
        switch sender.state {
        case NSControl.StateValue(rawValue: 1):
            let imgBut:NSImage? = NSImage(named: NSImage.Name(rawValue: "Stop"))
            sender.image = imgBut
            blogerFM.volume = volumeBarOutlet.floatValue
            blogerFM.replaceCurrentItem(with: blogerPlayerItem)
            blogerFM.play()
        case NSControl.StateValue(rawValue: 0):
            let altImgBt:NSImage? = NSImage(named: NSImage.Name(rawValue: "Play"))
            sender.image = altImgBt
            blogerFM.replaceCurrentItem(with: nil)
        default: break
        }
        
        
    }
    
    //Mute button
    @IBAction func muteButton(_ sender: NSButton) {
        
        if blogerFM.volume == 0.0{
            sender.state = NSControl.StateValue(rawValue: 0)
        }else{
            sender.state = NSControl.StateValue(rawValue: 1)
        }
        
        switch sender.state {
        case NSControl.StateValue(rawValue: 0):
            let imgBut:NSImage? = NSImage(named: NSImage.Name(rawValue: "UnMute"))
            sender.image = imgBut
            blogerFM.volume = volumeBarOutlet.floatValue
            
        case NSControl.StateValue(rawValue: 1):
            let altImgBt:NSImage? = NSImage(named: NSImage.Name(rawValue: "Mute"))
            sender.image = altImgBt
        blogerFM.volume = 0.0
        default: break
        }

        
    }
    
    // Oppen Preferencess window.
    @IBAction func blogerPreferencessAction(_ sender: NSMenuItem) {
        if preferencesWindow.isWindowLoaded{
            preferencesWindow.windowDidLoad()
        }else{
        removeBlogerObservers()
        preferencesWindow.showWindow(nil)
        }
    }
    
    
    @IBAction func quit(_ sender: NSMenuItem) {
        UserDefaults.standard.set(blogerFM.volume, forKey: "volume")
        UserDefaults.standard.set(ratePreference, forKey: "rate")
        NSApplication.shared.terminate(self)
        
        
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath != nil else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        var tempKeyPath: String
        if keyPath == nil {
            tempKeyPath = "nothing"
        }else{
            tempKeyPath = keyPath!
        }
        
        switch tempKeyPath {
        case "playbackBufferEmpty" :
            if blogerFM.currentItem!.isPlaybackBufferEmpty {
                blogerNotification(notify: NSLocalizedString("Buffer", comment: "Error has an accured"))
            }
            
        case "timedMetadata" :
            if blogerFM.currentItem?.timedMetadata != nil {
                for item in (blogerFM.currentItem?.timedMetadata)! as [AVMetadataItem]{
                    let data = String(describing: item.value!)
                    blogerNotification(notify: String(describing: data))
                }
            } else {
                blogerNotification(notify: NSLocalizedString("Error", comment: "Error has an accured"))
            }
        default:
            print ("Wrong key for observer")
        }
    }
    
    
    deinit {
        removeBlogerObservers()
    }
    func removeBlogerObservers () {
        blogerFM.currentItem?.removeObserver(self, forKeyPath: "playbackBufferEmpty")
        blogerFM.currentItem?.removeObserver(self, forKeyPath: "timedMetadata")
    }
    
    func addBlogerObservers() {
        blogerFM.currentItem?.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
        blogerFM.currentItem?.addObserver(self, forKeyPath: "timedMetadata", options: .new, context: nil)
    }
}
