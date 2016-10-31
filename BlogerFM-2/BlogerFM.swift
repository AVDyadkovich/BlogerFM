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

var url256 = "http://radio.bloger.fm:8000/blogerfm-256"

var blogerFMUrl256 = URL(string: url256)

var asset = AVURLAsset(url: blogerFMUrl256!)

var blogerPlayerItem = AVPlayerItem(asset: asset)

var blogerFM = AVPlayer(playerItem: blogerPlayerItem)



