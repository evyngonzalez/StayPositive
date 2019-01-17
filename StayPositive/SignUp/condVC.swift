//
//  condVC.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 5/23/18.
//  Copyright © 2018 Stay+. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class condVC: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    
    @IBOutlet weak var tableCondV: UITableView!
    
    
    let helpSought = [ "Depression" , "Stress/Anxiety" , "Addiction" , "PTSD" , "Marriage Counseling" , "Other (just looking to Stay Positive)"]
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(helpSought.count)
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = helpSought [indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        
        
        tableCondV.backgroundView = nil
        tableCondV.backgroundColor = UIColor.clear



        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        
        // cell.accessoryView.hidden = false // if using a custom image
    }
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .none
        // cell.accessoryView.hidden = true  // if using a custom image
        tableView.allowsMultipleSelection = true
    }

    
    
    // video background player
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableCondV.tableFooterView = UIView()


        
        tableCondV.delegate = self
        tableCondV.dataSource = self
        
        
            let URL = Bundle.main.url(forResource: "backgvid" , withExtension: "mov")
            view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
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
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

