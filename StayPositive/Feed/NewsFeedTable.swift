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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableView.automaticDimension

        
        let urls:[String] = ["https://www.nimh.nih.gov/site-info/index-rss.atom?format=xml", "https://blogs.psychcentral.com/feed","https://www.psychologytoday.com/blog/both-sides-the-couch/feed"]
       fetchData(urls: urls)
    }
    
    private func fetchData(urls: [String])
    {
        let feedParser = FeedParser()
        for urlIn in urls{
            feedParser.parseFeed(url: urlIn) { (rssItems) in
                self.rssItems = rssItems
                self.cellStates = Array(repeating: .collapsed, count: rssItems.count)
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
                }
            }
        }

    }
    func imgFetch(){
    
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

/*
 func tableView(_tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    let item = rssItems?[indexPath.row] as! RSSItem
        let webBrowser = NewsFeedTable()
        
    item.entryUrl = RSSItem?[indexPath.item].url
    UINavigationController?.pushViewController(webBrowser, animated: true)
    
    tableView.deselectRow(at: indexPath as IndexPath, animated: true)

        self.navigationController?.pushViewController(webBrowser, animated: true)
        
    }
}
    /*
    func tableView(_tableView: UITableViewCell, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let controller = NewsTableViewCell(tableView: UITableViewCell())
    controller.entryUrl = RSSItem?[indexPath.item].url
    UINavigationController?.pushViewController(controller, animated: true)
    }

    
}











 */*/
