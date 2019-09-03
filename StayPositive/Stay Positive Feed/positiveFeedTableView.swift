//
//  positiveFeedTableView.swift
//  StayPositive
//
//  Created by MACBOOK on 7/16/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import UIKit
import Firebase

class positiveFeedTableViewController: UITableViewController {
    
    var chats = [Chat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // observeEventType is called whenever anything changes in the Firebase - new Chats or Votes.
        // It's also called here in viewDidLoad().
        // It's always listening.
        
        DataService.dataService.CHAT_REF.observe(.value, with: { snapshot in
            
            // The snapshot is a current look at our chats data.
            
            print(snapshot.value as Any)
            
            self.chats = []
            
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshots {
                    
                    // Make our chats array for the tableView.
                    
                    if let postDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let chat = Chat(key: key, dictionary: postDictionary)
                        
                        // Items are returned chronologically, but it's better to have newest chats returned first.
                        
                        self.chats.insert(chat, at: 0)
                    }
                }
                
            }
            
            // Be sure that the tableView updates when there is new data.
            
            self.tableView.reloadData()
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chats.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let chat = chats[indexPath.row]
        
        // We are using a custom cell.
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCellTableViewCell") as? ChatCellTableViewCell {
            
            // Send the single chat to configureCell() in ChatCellTableViewCell.
            
            cell.configureCell(chat: chat)
            
            return cell
            
        } else {
            
            return ChatCellTableViewCell()
            
        }
        
    }
    
    
}
