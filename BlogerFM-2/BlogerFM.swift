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

var url = "http://radio.bloger.fm:8000/blogerfm-256"

var testUrl1 = URL(string: url)

var asset = AVURLAsset(url: testUrl1!)

var blogerPlayerItem = AVPlayerItem(asset: asset)

var blogerFM = AVPlayer(playerItem: blogerPlayerItem)



