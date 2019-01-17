//
//  IntroViewController.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 11/13/17.
//  Copyright © 2017 Stay+. All rights reserved.
//

import UIKit
import AVFoundation


class IntroViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    
        
        let URL = Bundle.main.url(forResource: "IMG_5401" , withExtension: "mov")
        
        Player = AVPlayer.init(url: URL!)
        PlayerLayer = AVPlayerLayer(player: Player)
        PlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        PlayerLayer.frame = view.layer.frame
        Player.volume = 0
        
        
        Player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        Player.play()
        
        view.layer.insertSublayer(PlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: Player.currentItem)
    }
    
    
    func playerItemReachEnd(notification: NSNotification) {
        Player.seek(to:kCMTimeZero)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


    
}
