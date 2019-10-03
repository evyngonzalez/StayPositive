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
import FirebaseAuth

class newEmailPass: UIViewController, UITextFieldDelegate {
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    
    @IBOutlet var ProfilePicture: UIImageView!
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    
    var databaseRef = Database.database().reference()
    let stayPositiveString = "gs://staypositive-a3bb0.appspot.com/"
    var selectedImage: UIImage?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        email.resignFirstResponder()
        password.resignFirstResponder()
        confirmPass.resignFirstResponder()
        return true
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        if password.text != confirmPass.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!){ (user, error) in
                if error == nil {
                self.databaseRef.child("users").child(user!.user.uid).child("email").setValue(self.email.text!)
                    let user = user?.user.uid
                    let storageRef = Storage.storage().reference(forURL: self.stayPositiveString).child("profilePicture").child("")
                    let text = self.usernameText.text!
                    self.databaseRef.child("users").child(user!).child("username").setValue(text)

                    if let profileImage = self.selectedImage, let imageData = profileImage.jpegData(compressionQuality: 0.1) {
                        storageRef.putData(imageData, metadata: nil, completion: { (metaData, error) in
                            if error != nil {
                                return
                            }
                            let profileImageURL = storageRef.child("\(profileImage)")
                            let ref = Database.database().reference()
                            let userReference = ref.child("users")
                            let newUserReference = userReference.child(user!)
                            newUserReference.setValue(["email": self.email.text!, "profileImageURL": profileImageURL])
                        })
                    }
                    self.performSegue(withIdentifier: "signUp", sender: self)
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        email.delegate = self
        password.delegate = self
        confirmPass.delegate = self
        
        let URL = Bundle.main.url(forResource: "backgvid" , withExtension: "mov")
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        Player = AVPlayer.init(url: URL!)
        PlayerLayer = AVPlayerLayer(player: Player)
        PlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        PlayerLayer.frame = view.layer.frame
        Player.volume = 0
        
        Player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        Player.play()
        
        view.layer.insertSublayer(PlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: Player.currentItem)
    }
    @objc func playerItemReachEnd(notification: NSNotification) {
        Player.seek(to:CMTime.zero)
    }
}
