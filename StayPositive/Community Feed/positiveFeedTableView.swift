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
    
    @IBOutlet var addButton: UIBarButtonItem!
    
    var chats = [Chat]()
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.dataService.CHAT_REF.observe(.value, with: { snapshot in
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
    @IBAction func addChatSegue(_ sender: Any) {
        performSegue(withIdentifier: "AddChat", sender: self)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell Tapped")
        performSegue(withIdentifier: "viewChat", sender: self)
    }
}
