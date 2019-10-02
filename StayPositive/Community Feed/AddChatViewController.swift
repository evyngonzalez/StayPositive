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

class AddChatViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var saveChatButton: UIButton!
    @IBOutlet weak var chatField: UITextField!
    
    var currentUsername = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Error with the code here")
        subscribeToKeyboardNotifications()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func saveChat(_ sender: Any) {
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        chatField.resignFirstResponder()
        return true
    }
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if chatField.isFirstResponder == true {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height - 50
                }
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
            self.view.frame.origin.y = 0
    }
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}
