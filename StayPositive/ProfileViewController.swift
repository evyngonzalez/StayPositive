//
//  ProfileViewController.swift
//  StayPositive
//
//  Created by MACBOOK on 8/28/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Firebase


class profileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var pastChat: UITableView!
    @IBOutlet var logout: UIBarButtonItem!
    @IBOutlet var saveButton: UIButton!
    
    let storageRef = Storage.storage().reference(forURL: "gs://staypositive-a3bb0.appspot.com/").child("profilePicture").child("")
    
    let databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfile()
        reloadUser()
        saveButton.isHidden = true
    }
    
    @objc func handleSelectProfileImageView() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
        print("Tapped profile")
    }
    
    
    @IBAction func saveStuff(_ sender: Any) {
        saveChanges()
        saveButton.isHidden = true
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    @IBAction func uploadImageButton(_ sender: Any) {
        saveButton.isHidden = false
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
        print("Tapped the profile image")
    }
    
    
    
    func sendEmailVerification(_ callback: ((Error?) -> ())? = nil){
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            callback?(error)
        })
    }
    
    // reloading user. Sometimes used after updating or verifying email address etc.
    func reloadUser(_ callback: ((Error?) -> ())? = nil){
        Auth.auth().currentUser?.reload(completion: { (error) in
            callback?(error)
        })
    }
    
    // Resetting password. Not yet implemented in this
    
    func sendPasswordReset(withEmail email: String, _ callback: ((Error?) -> ())? = nil){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            callback?(error)
        }
    }
    
    func setupProfile(){
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        if let uid = Auth.auth().currentUser?.uid{
            databaseRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    self.nameLabel.text = dict["username"] as? String
                    if let profileImageURL = dict["profilePicture"] as? String
                    {
                        let url = URL(string: profileImageURL)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil{
                                print(error!)
                                return
                            }
                            DispatchQueue.main.async {
                                self.profilePicture?.image = UIImage(data: data!)
                            }
                        }).resume()
                    }
                }
            })
        }
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
            
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker{
            profilePicture.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func saveChanges(){
        
        let imageName = NSUUID().uuidString
        
        let storedImage = storageRef.child("profilePicture").child(imageName)
        
        if let uploadData = self.profilePicture.image!.pngData()
        {
            storedImage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error!)
                    return
                }
                storedImage.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    if let urlText = url?.absoluteString{
                        self.databaseRef.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["profilePicture" : urlText], withCompletionBlock: { (error, ref) in
                            if error != nil{
                                print(error!)
                                return
                            }
                        })
                    }
                })
            })
        }
    }
}
