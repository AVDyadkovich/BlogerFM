//
//  BlogerFM.swift
//  BlogerFM
//
//  Created by Андрей on 13.10.16.
//  Copyright © 2016 Andy. All rights reserved.
//

import Foundation
import CoreAudioKit
import AVFoundation

let notification = NSUserNotification.init()
var ratePreference = UserDefaults.standard.string(forKey: "rate") ?? "128"

// Url of radio stream:

enum BlogerFMUrl: String{
    case url64 = "http://radio.bloger.fm:8000/blogerfm-64"
    case url128 = "http://radio.bloger.fm:8000/blogerfm-128"
    case url256 = "http://radio.bloger.fm:8000/blogerfm-256"
}

var blogerFMUrl = URL(string: changeRateUrl(rate: ratePreference))

var blogerPlayerItem = AVPlayerItem(url: blogerFMUrl!)

var blogerFM = AVPlayer(playerItem: blogerPlayerItem)
//Changing rate form preferencess method.
func changeRateUrl (rate: String) -> String {
    switch rate{
        case "64": return BlogerFMUrl.url64.rawValue
        case "128": return BlogerFMUrl.url128.rawValue
        case "256": return BlogerFMUrl.url256.rawValue
    default: return "Nil"
    }
}
//Restart player method
func restartBloger (){
 
    blogerFMUrl = URL(string: changeRateUrl(rate: ratePreference))
    blogerPlayerItem = AVPlayerItem(url: blogerFMUrl!)
    blogerFM.replaceCurrentItem(with: blogerPlayerItem)
    StatusMenuController.awakeFromNib()
}
// Notification method for player. 
func blogerNotification(notify:String) {
    notification.title = "BlogerFM"
    notification.informativeText = notify
    notification.contentImage = NSImage(named: "status")
    NSUserNotificationCenter.default.deliver(notification)
}





