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
var ratePreference = "256"

// Url of radio stream:

enum BlogerFMUrl: String{
    case url256 = "http://radio.bloger.fm:8000/blogerfm-256"
    case url128 = "http://radio.bloger.fm:8000/blogerfm-128"
    case url512 = "http://radio.bloger.fm:8000/blogerfm-512"
}

//var url256 = "http://radio.bloger.fm:8000/blogerfm-256"


var blogerFMUrl = URL(string: changeRateUrl(rate: ratePreference))


//Initialize of player with Item

var blogerPlayerItem = AVPlayerItem(url: blogerFMUrl!)

var blogerFM = AVPlayer(playerItem: blogerPlayerItem)

func changeRateUrl (rate: String) -> String {
    switch rate{
        case "128": return BlogerFMUrl.url128.rawValue
        case "256": return BlogerFMUrl.url256.rawValue
        case "512": return BlogerFMUrl.url512.rawValue
    default: return "Nil"
    }
}

func restartBloger (){
 
    blogerFMUrl = URL(string: changeRateUrl(rate: ratePreference))
    blogerPlayerItem = AVPlayerItem(url: blogerFMUrl!)
   // blogerFM = AVPlayer(playerItem: blogerPlayerItem)
    //blogerFM.replaceCurrentItem(with: AVPlayerItem(url:blogerFMUrl!))
    blogerFM.replaceCurrentItem(with: blogerPlayerItem)
    StatusMenuController.awakeFromNib()
}
