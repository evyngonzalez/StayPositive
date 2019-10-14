//
//  videoFeedController.swift
//  StayPositive
//
//  Created by MACBOOK on 9/26/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AVKit

    let videoUrl = URL(string: "https://v.cdn.vine.co/r/videos/AA3C120C521177175800441692160_38f2cbd1ffb.1.5.13763579289575020226.mp4")!
class videoFeedController: UIViewController {

    fileprivate var player = Player()
    
    // MARK: object lifecycle
    deinit {
        self.player.willMove(toParent: nil)
        self.player.view.removeFromSuperview()
        self.player.removeFromParent()
    }

    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.player.playerDelegate = self
//        self.player.playbackDelegate = self
            
        self.player.playerView.playerBackgroundColor = .black
            
        self.addChild(self.player)
        self.view.addSubview(self.player.view)
        self.player.didMove(toParent: self)
            
    //        let localUrl = Bundle.main.url(forResource: "IMG_3267", withExtension: "MOV")
    //        self.player.url = localUrl
        self.player.url = videoUrl
        
        self.player.playbackLoops = true
            
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer(_:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
        self.player.view.addGestureRecognizer(tapGestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.player.playFromBeginning()
    }
}

    // MARK: - UIGestureRecognizer
extension videoFeedController {
        
    @objc func handleTapGestureRecognizer(_ gestureRecognizer: UITapGestureRecognizer) {
        switch (self.player.playbackState.rawValue) {
            case PlaybackState.stopped.rawValue:
                self.player.playFromBeginning()
                break
            case PlaybackState.paused.rawValue:
                self.player.playFromCurrentTime()
                break
            case PlaybackState.playing.rawValue:
                self.player.pause()
                break
            case PlaybackState.failed.rawValue:
                self.player.pause()
                break
            default:
                self.player.pause()
                break
        }
    }
        
}
    // MARK: - PlayerDelegate

extension videoFeedController: PlayerDelegate {
        
    func playerReady(_ player: Player) {
        print("\(#function) ready")
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        print("\(#function) \(player.playbackState.description)")
    }
        
    func playerBufferingStateDidChange(_ player: Player) {
    }
        
    func playerBufferTimeDidChange(_ bufferTime: Double) {
    }
        
    func player(_ player: Player, didFailWithError error: Error?) {
        print("\(#function) error.description")
    }
        
}
    // MARK: - PlayerPlaybackDelegate

extension ViewController: PlayerPlaybackDelegate {
    func playerCurrentTimeDidChange(_ player: Player) {
    }
        
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
        
    func playerPlaybackDidEnd(_ player: Player) {
    }
        
    func playerPlaybackWillLoop(_ player: Player) {
    }
        
}
