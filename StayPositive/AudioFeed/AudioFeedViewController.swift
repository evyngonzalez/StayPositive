//
//  AudioFeedViewController.swift
//  StayPositive
//
//  Created by MACBOOK on 10/21/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class AudioFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var audios: [Audio] = []
    
    var player: AVAudioPlayer?
    let AudioCellReuseIdentifier = "AudioCell"
    let tableView = UITableView()
  

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        let feed = self
        feed.audios = Audio.allAudio()
        feed.title = "Audio"
        navigationController?.navigationBar.isTranslucent = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = true
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AudioCellReuseIdentifier, for: indexPath) as? AudioTableViewCell else {
            return AudioTableViewCell()
        }
        cell.audio = audios[indexPath.row] 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let audio = audios[indexPath.row]
        return AudioTableViewCell.height(for: audio)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            let audio = audios[indexPath.row]
            let audioURL = audio.url
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.play()
            print("Tapped audio file")
        }  catch {
            print("Error trying to play")
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audios.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

