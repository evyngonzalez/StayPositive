//
//  PlayerView.swift
//  StayPositive
//
//  Created by MACBOOK on 10/21/19.
//  Copyright © 2019 Stay+. All rights reserved.
//


import UIKit
import AVFoundation

class AudioPlayerView: UIView {
  var player: AVPlayer? {
    get {
      return playerLayer.player
    }

    set {
      playerLayer.player = newValue
    }
  }
  
  override class var layerClass: AnyClass {
    return AVPlayerLayer.self
  }
  
  var playerLayer: AVPlayerLayer {
    return layer as! AVPlayerLayer
  }
}
