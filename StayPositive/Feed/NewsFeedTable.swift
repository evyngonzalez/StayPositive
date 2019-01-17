//
//  NewsFeedTable.swift
//  StayPositive
//
//  Created by Evyn Gonzalez  on 12/28/18.
//  Copyright © 2018 Stay+. All rights reserved.
//

import UIKit

class NewsFeedTable: UITableViewController {

    private var rssItems: [RSSItem]?
    private var cellStates: [CellState]?
    //private var urls
    //private var urls.length
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //for i => n:
        //fetchData(i)
        fetchData()
    }
    
    private func fetchData()
    {
        let feedParser = FeedParser()
         feedParser.parseFeed(url: "https://www.psychologytoday.com/us/blog/both-sides-the-couch/feed" ) { (rssItems) in
            self.rssItems = rssItems
            self.cellStates = Array(repeating: .collapsed, count: rssItems.count)
            
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard let rssItems = rssItems else {
            return 0
        }
        
        // rssItems
        return rssItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        if let item = rssItems?[indexPath.item] {
            cell.item = item
            cell.selectionStyle = .none
            
            if let cellStates = cellStates {
                cell.descriptionLabel.numberOfLines = (cellStates[indexPath.row] == .expanded) ? 0 : 4
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = (cell.descriptionLabel.numberOfLines == 0) ? 3 : 0
        
        cellStates?[indexPath.row] = (cell.descriptionLabel.numberOfLines == 0) ? .expanded : .collapsed
        
        tableView.endUpdates()
    }
    
}












