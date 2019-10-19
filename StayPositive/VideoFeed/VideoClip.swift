//
//  VideoClip.swift
//  StayPositive
//
//  Created by MACBOOK on 10/18/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import UIKit

class VideoClip: NSObject {
  let url: URL
  
  init(url: URL) {
    self.url = url
    super.init()
  }
  
  class func allClips() -> [VideoClip] {
    var clips: [VideoClip] = []
    
//    // Add HLS Stream to the beginning of clip show
//    if let url = URL(string: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8") {
//      let remoteVideo = VideoClip(url: url)
//      clips.append(remoteVideo)
//    }

    let names = ["Test1", "Test2", "Test3", "Test4", "Test5"]
    for name in names {
      let urlPath = Bundle.main.path(forResource: name, ofType: "mp4")!
      let url = URL(fileURLWithPath: urlPath)
      
      let clip = VideoClip(url: url)
      clips.append(clip)
    }

    return clips
  }
}
