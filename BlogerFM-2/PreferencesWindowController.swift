//
//  PreferencesWindowController.swift
//  BlogerFM-2
//
//  Created by Андрей on 18.11.16.
//  Copyright © 2016 Andy. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController {

    @IBOutlet weak var changeRate: NSMatrix!
    var statusController = StatusMenuController()
    
    override var windowNibName: String!{
        return "PreferencesWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
    }
    @IBAction func SaveButton(_ sender: NSButton) {
   //     blogerFM.currentItem?.removeObserver(StatusMenuController.self() , forKeyPath: "playbackBufferEmpty")
        ratePreference = (changeRate.selectedCell()?.title)!
        restartBloger()
        print(blogerFMUrl!)
        self.close()
    }
    
}
