//
//  Videos.swift
//  StayPositive
//
//  Created by MACBOOK on 10/18/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import UIKit

class Video: NSObject {
  let url: URL
  let thumbURL: URL
  let title: String
  let subtitle: String

  init(url: URL, thumbURL: URL, title: String, subtitle: String) {
    self.url = url
    self.thumbURL = thumbURL
    self.title = title
    self.subtitle = subtitle
    super.init()
  }
  
  class func localVideos() -> [Video] {
    var videos: [Video] = []
    let names = ["Test1", "Test2", "Test3", "Test4"]
    let titles = ["Test title video one", "Test title video two", "Test title video three", "Test title video four"]
    let subtitles = ["Test subtitle for video one",
                     "Test subtitle for video two",
                     "Test subtitle for video three",
                     "Test subtitle for video four"]
    
    for (index, name) in names.enumerated() {
      let urlPath = Bundle.main.path(forResource: name, ofType: "mp4")!
      let url = URL(fileURLWithPath: urlPath)
      let thumbURLPath = Bundle.main.path(forResource: name, ofType: "png")!
      let thumbURL = URL(fileURLWithPath: thumbURLPath)
      
      let video = Video(url: url, thumbURL: thumbURL, title: titles[index], subtitle: subtitles[index])
      videos.append(video)
    }
    return videos
  }
  
  class func allVideos() -> [Video] {
    var videos = localVideos()
    
    // Add one remote video
    let videoURLString = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
    if let url = URL(string: videoURLString) {
      let thumbURLPath = Bundle.main.path(forResource: "Test5", ofType: "png")!
      let thumbURL = URL(fileURLWithPath: thumbURLPath)
      let remoteVideo = Video(url: url, thumbURL: thumbURL, title: "Test title remote video", subtitle: "Test subtitle for the remote linked video")
      videos.append(remoteVideo)
    }
    return videos
  }
}

