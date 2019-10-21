//
//  Audio.swift
//  StayPositive
//
//  Created by MACBOOK on 10/21/19.
//  Copyright © 2019 Stay+. All rights reserved.
//


import UIKit

class Audio: NSObject {
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
  
  class func localAudios() -> [Audio] {
    var audios: [Audio] = []
    let names = ["Test1", "Test2", "Test3", "Test4"]
    let titles = ["Test title audio one", "Test title audio two", "Test title audio three", "Test title audio four"]
    let subtitles = ["Test subtitle for audio one",
                     "Test subtitle for audio two",
                     "Test subtitle for audio three",
                     "Test subtitle for audio four"]
    
    for (index, name) in names.enumerated() {
      let urlPath = Bundle.main.path(forResource: name, ofType: "mp3")!
      let url = URL(fileURLWithPath: urlPath)
      let thumbURLPath = Bundle.main.path(forResource: name, ofType: "png")!
      let thumbURL = URL(fileURLWithPath: thumbURLPath)
      
      let audio = Audio(url: url, thumbURL: thumbURL, title: titles[index], subtitle: subtitles[index])
      audios.append(audio)
    }
    return audios
  }
  
  class func allAudio() -> [Audio] {
    var audios = localAudios()
    let audioURLString = "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8"
    if let url = URL(string: audioURLString) {
      let thumbURLPath = Bundle.main.path(forResource: "Test5", ofType: "png")!
      let thumbURL = URL(fileURLWithPath: thumbURLPath)
      let remoteAudio = Audio(url: url, thumbURL: thumbURL, title: "Test title remote audio", subtitle: "Test subtitle for the remote linked Audio")
      audios.append(remoteAudio)
    }
    return audios
  }
}

