//
//  newEmailPass.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 5/22/18.
//  Copyright © 2018 Stay+. All rights reserved.
//

import Firebase
import UIKit
import AVFoundation

class newEmailPass: UIViewController {
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    @IBOutlet weak var signUp: UIButton!
    
    @IBOutlet weak var confirmPass: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    var databaseRef = Database.database().reference()

    
    @IBAction func signUpTapped(_ sender: Any) {
        
        
        //Create user
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if error != nil{
                //Print a message for success
                self.errorMessage.textColor = UIColor.red
                self.errorMessage.text = error?.localizedDescription
            } else {
                self.errorMessage.textColor = UIColor.green
                self.errorMessage.text = "Registered Successfully"
                //Sign In the user
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion:
                    { (user, error) in
                        if error == nil{
                            //Make entry in database
                            self.databaseRef.child("users").child(user!.user.uid).child("email").setValue(self.email.text!)
                            //Perform segue to success
                            self.performSegue(withIdentifier: "signUp", sender: nil)
                        }
                })
            }
        
    }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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


