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

// Url of radio stream:

enum BlogerFMUrl: String{
    case url256 = "http://radio.bloger.fm:8000/blogerfm-256"
    case url128 = "http://radio.bloger.fm:8000/blogerfm-128"
}

//var url256 = "http://radio.bloger.fm:8000/blogerfm-256"

var blogerFMUrl = URL(string: BlogerFMUrl.url256.rawValue)

//var blogerFMUrl = blogerFMUrl256

//var asset = AVURLAsset(url: blogerFMUrl256!)


//Initialize of player with Item

var blogerPlayerItem = AVPlayerItem(url: blogerFMUrl!)

var blogerFM = AVPlayer(playerItem: blogerPlayerItem)
