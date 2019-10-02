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
    @IBOutlet weak var thumbVoteImage: UIImageView!
    
    var chat: Chat!
    var voteRef: DatabaseReference!
    
    func configureCell(chat: Chat) {
        self.chat = chat
        // Set the labels and textView.
        self.chatText.text = chat.chatText
        self.totalVotesLabel.text = "Total Votes: \(chat.chatVotes)"
        self.usernameLabel.text = chat.username
                
        voteRef = DataService.dataService.CURRENT_USER_REF.child("votes").child(chat.chatKey)
                
        voteRef.observeSingleEvent(of: .value, with: { snapshot in
            if let thumbsUpDown = snapshot.value as? NSNull {
                                
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "upvoteGray")
            } else {
                            
                self.thumbVoteImage.image = UIImage(named: "upvoteBlue")
            }
        })
    }
    
    @IBAction func voteTapped(_ sender: Any) {

        voteRef.observeSingleEvent(of: .value, with: { snapshot in
            
            if let thumbsUpDown = snapshot.value as? NSNull {
                print(thumbsUpDown)
                self.thumbVoteImage.image = UIImage(named: "thumb-down")
                                
                self.chat.addSubtractVote(addVote: true)

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
        let tap = UITapGestureRecognizer(target: self, action: Selector(("voteTapped:")))
        tap.numberOfTapsRequired = 1
        thumbVoteImage.addGestureRecognizer(tap)
        thumbVoteImage.isUserInteractionEnabled = true
    }
    
}
