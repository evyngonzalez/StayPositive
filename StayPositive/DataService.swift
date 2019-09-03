//
//  DataService.swift
//  StayPositive
//
//  Created by MACBOOK on 7/16/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataService {
    static let dataService = DataService()
    
    
    private var _BASE_REF = Database.database().reference(fromURL: "\(BASE_URL)")
    private var _USER_REF = Database.database().reference(fromURL: "\(BASE_URL)/users")
    private var _CHAT_REF = Database.database().reference(fromURL: "\(BASE_URL)/chats")
    
    var BASE_REF: DatabaseReference! {
        return _BASE_REF
    }
    
    var USER_REF: DatabaseReference! {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: DatabaseReference! {
        let userID = UserDefaults.standard.value(forKey: "uid") as! String
        
        let currentUser = Database.database().reference(fromURL: "\(String(describing: BASE_REF))").child(byAppendingPath: "users").child(byAppendingPath: userID)
        
        return currentUser
    }
    
    var CHAT_REF: DatabaseReference! {
        return _CHAT_REF
    }
    
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
        // A User is born.
        
        USER_REF.child(byAppendingPath: uid).setValue(user)
    }
    
    func createNewChat(chat: Dictionary<String, AnyObject>) {
        
        // Save the chat
        // CHAT_REF is the parent of the new chat: "chats".
        // childByAutoId() saves the chat and gives it its own ID.
        
        let firebaseNewChat = CHAT_REF.childByAutoId()
        
        // setValue() saves to Firebase.
        
        firebaseNewChat.setValue(chat)
    }
}
