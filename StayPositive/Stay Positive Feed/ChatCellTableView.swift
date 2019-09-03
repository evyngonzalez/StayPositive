//
//  ChatCellTableView.swift
//  StayPositive
//
//  Created by MACBOOK on 7/18/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import UIKit
import Firebase

class ChatCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chatText: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var totalVotesLabel: UILabel!
    @IBOutlet var thumbVoteImage: UIImageView!
    
    var chat: Chat!
    var voteRef: DatabaseReference!
    
    func configureCell(chat: Chat) {
        self.chat = chat
        
        // Set the labels and textView.
        
        self.chatText.text = chat.chatText
        self.totalVotesLabel.text = "Total Votes: \(chat.chatVotes)"
        self.usernameLabel.text = chat.username
        
        // Set "votes" as a child of the current user in Firebase and save the chat's key in votes as a boolean.
        
        voteRef = DataService.dataService.CURRENT_USER_REF.child(byAppendingPath: "votes").child(byAppendingPath: chat.chatKey)
        
        // observeSingleEventOfType() listens for the thumb to be tapped, by any user, on any device.
        
        voteRef.observeSingleEvent(of: .value, with: { snapshot in
            
            // Set the thumb image.
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                
                // Current user hasn't voted for the chat... yet.
                
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
            } else {
                
                // Current user voted for the chat!
                
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
            }
        })
    }
    
    func voteTapped(sender: UITapGestureRecognizer) {
        
        // observeSingleEventOfType listens for a tap by the current user.
        
        voteRef.observeSingleEvent(of: .value, with: { snapshot in
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
                
                // addSubtractVote(), in Chat.swift, handles the vote.
                
                self.chat.addSubtractVote(addVote: true)
                
                // setValue saves the vote as true for the current user.
                // voteRef is a reference to the user's "votes" path.
                
                self.voteRef.setValue(true)
            } else {
                self.thumbVoteImage.image = UIImage(named: "thumb-up")
                self.chat.addSubtractVote(addVote: false)
                self.voteRef.removeValue()
            }
            
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // UITapGestureRecognizer is set programatically.
        
        let tap = UITapGestureRecognizer(target: self, action: Selector(("voteTapped:")))
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.isUserInteractionEnabled = true
    }
    
}
