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
        changeRate.selectCell(withTag: Int(ratePreference)!)
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
    }
    @IBAction func SaveButton(_ sender: NSButton) {
        ratePreference = (changeRate.selectedCell()?.title)!
        restartBloger()
        self.close()
    }
    
}
