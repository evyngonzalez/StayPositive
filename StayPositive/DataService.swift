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
        let userID = UserDefaults.standard.value(forKey: "verificationId") as! String
        
        let currentUser = Database.database().reference(fromURL: "https://staypositive-a3bb0.firebaseio.com").child("users").child(userID)
        return currentUser
    }
    var CHAT_REF: DatabaseReference! {
        return _CHAT_REF
    }
    func createNewAccount(uid: String, user: Dictionary<String, String>) {
        
            USER_REF.child(uid).setValue(user)
    }
    func createNewChat(chat: Dictionary<String, AnyObject>) {
        let firebaseNewChat = CHAT_REF.childByAutoId()
        firebaseNewChat.setValue(chat)
    }
}
