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


class videoFeedController: UITableViewController {
    
    @IBOutlet var videoTableView: UITableView!
    
    var audioPlayer = AVAudioPlayer()
    var posts = [Post]()
    let musicRef = Storage.storage().reference(forURL: "gs://soundplg-5c8e6.appspot.com/").child("songAudio").child("")
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoTableView.delegate = self
        downloadVideoPost()
    }
    
    let localURL = URL(string: "songAudio")!
    func downloadVideoPost(){
        let userPostRef = self.databaseRef.child("memePost")
        userPostRef.queryOrdered(byChild: "time").observe(.childAdded, with: {(snapshot) in
            if let postAdd  = snapshot.value as? NSDictionary {
                let dict = snapshot.value as? [String: AnyObject]
                print("\(snapshot.value)")
                let url = dict?["audioURL"] as? String
                let coverPhotoUrl = dict!["coverImage"] as? String
                let audioTitle = dict!["postTitle"] as? String
                
                var myPost = Post(data: postAdd) //variable change to "var" because going to modify
                let url2 = NSURL(string: url ?? "")  //postPhoto URL
                let data = NSData(contentsOf: url2! as URL) // this URL convert into Data
                if data != nil {  //Some time Data value will be nil so we need to validate such things
                    myPost.audioURL = String(describing: data! as Data)
                }
                let url3 = NSURL(string: coverPhotoUrl ?? "")  //userPhoto URL
                let data2 = NSData(contentsOf: url3! as URL)  //Convert into data
                if data2 != nil  {  //check the data
                    myPost.coverImage = UIImage(data: data2! as Data)  //store in image
                }
                let url4 = NSURL(string: audioTitle ?? "")  //userPhoto URL
                let data3 = NSData(contentsOf: url4! as URL)  //Convert into data
                if data3 != nil  {  //check the data
                    myPost.postTitle = String(describing: data2! as Data)  //store in image
                }
                self.posts.insert(myPost, at: 0)  // then add the "myPost"  Variable
                print(self.posts.count)
            }
            self.tableView.reloadData()  // finally going to load the collection of data in tableview
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoFeedCell", for: indexPath) as! videoFeedCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: localURL)
            audioPlayer.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
}
