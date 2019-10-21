//
//  homeFeedViewController.swift
//  StayPositive
//
//  Created by MACBOOK on 8/27/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit

class homeFeedViewController: UIViewController {
    
    @IBOutlet var videoFeed: UIButton!
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.black
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    
    let videoController = VideoFeedViewController()
    let audioController = AudioFeedViewController()

    
    @IBAction func videoFeedButtonTapped(_ sender: Any) {
        self.show(videoController, sender: self)
    }
    
    @IBAction func audioFeedButtonTapped(_ sender: Any) {
        self.show(audioController, sender: self)
    }
    
}
