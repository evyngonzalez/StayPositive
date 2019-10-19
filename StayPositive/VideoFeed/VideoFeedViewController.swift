//
//  VideoFeedViewController.swift
//  StayPositive
//
//  Created by MACBOOK on 10/18/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class VideoFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var videos: [Video] = []
    
  
    let VideoCellReuseIdentifier = "VideoCell"
    let tableView = UITableView()
  
//    let videoPreviewLooper = VideoLooperView(clips: VideoClip.allClips())

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        let feed = self
        feed.videos = Video.allVideos()
        feed.title = "Therapy"

//        videoPreviewLooper.play()
        navigationController?.navigationBar.isTranslucent = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
//        videoPreviewLooper.pause()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCellReuseIdentifier, for: indexPath) as? VideoTableViewCell else {
            return VideoTableViewCell()
        }
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let video = videos[indexPath.row]
        return VideoTableViewCell.height(for: video)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let video = videos[indexPath.row]

        let videoURL = video.url
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
    
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

