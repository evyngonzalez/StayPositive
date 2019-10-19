//
//  VideoPlayerView.swift
//  StayPositive
//
//  Created by MACBOOK on 10/18/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
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
