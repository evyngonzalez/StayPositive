//
//  AddChatViewController.swift
//  StayPositive
//
//  Created by MACBOOK on 7/17/19.
//  Copyright © 2019 Stay+. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase

class AddChatViewController: UIViewController {
    
    @IBOutlet weak var chatField: UITextField!
    
    var currentUsername = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get username of the current user, and set it to currentUsername, so we can add it to the Chat.
        
        DataService.dataService.CURRENT_USER_REF?.observe(DataEventType.value, with: { snapshot in
            
            let currentUser = (snapshot.value as AnyObject).object(forKey: "username") as! String
            
            print("Username: \(currentUser)")
            self.currentUsername = currentUser
        }, withCancel: { error in
            print(error.localizedDescription)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func saveChat(sender: AnyObject) {
        let chatText = chatField.text
        
        if chatText != "" {
            
            // Build the new Chat.
            // AnyObject is needed because of the votes of type Int.
            
            let newChat: Dictionary<String, AnyObject> = [
                "chatText": chatText! as AnyObject,
                "votes": 0 as AnyObject,
                "author": currentUsername as AnyObject
            ]
            
            // Send it over to DataService to seal the deal.
            
            DataService.dataService.createNewChat(chat: newChat)
            
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
}
}
