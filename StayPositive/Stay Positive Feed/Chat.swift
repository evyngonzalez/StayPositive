//
//  Chat.swift
//  StayPositive
//
//  Created by MACBOOK on 7/16/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import Firebase

class Chat {
    private var _chatRef: DatabaseReference!
    
    private var _chatKey: String!
    private var _chatText: String!
    private var _chatVotes: Int!
    private var _username: String!
    
    var chatKey: String {
        return _chatKey
    }
    
    var chatText: String {
        return _chatText
    }
    
    var chatVotes: Int {
        return _chatVotes
    }
    
    var username: String {
        return _username
    }
    
    // Initialize the new Chat
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._chatKey = key
        
        // Within the Chat, or Key, the following properties are children
        
        if let votes = dictionary["votes"] as? Int {
            self._chatVotes = votes
        }
        
        if let chat = dictionary["chatText"] as? String {
            self._chatText = chat
        }
        
        if let user = dictionary["author"] as? String {
            self._username = user
        } else {
            self._username = ""
        }
        
        // The above properties are assigned to their key.
        
        self._chatRef = DataService.dataService.CHAT_REF.child(byAppendingPath: self._chatKey)
    }
    
    func addSubtractVote(addVote: Bool) {
        
        if addVote {
            _chatVotes = _chatVotes + 1
        } else {
            _chatVotes = _chatVotes - 1
        }
        
        // Save the new vote total.
        
        _chatRef.child("votes").setValue(_chatVotes)
    }
}

