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
    // Implement of chenge and save method.
    @IBAction func SaveButton(_ sender: NSButton) {
        if ratePreference != (changeRate.selectedCell()?.title)!{
            ratePreference = (changeRate.selectedCell()?.title)!
            restartBloger()
            blogerNotification(notify: NSLocalizedString("Changerate", comment: "Rate has been changed") + "\(ratePreference) kb/s")
        }else{
            blogerNotification(notify: NSLocalizedString("Remainrate", comment: "Rate didn't change") + "\(ratePreference) kb/s")
        }
        self.close()
    }
    
}
