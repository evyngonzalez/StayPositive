//
//  FeedViewController.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 7/3/17.
//
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  UISearchBarDelegate, UITabBarDelegate {

    @IBOutlet weak var searchBr: UISearchBar!
    @IBOutlet weak var tableView : UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        self.searchBr.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        searchBr.delegate = self
        searchBr.returnKeyType = UIReturnKeyType.done
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
          }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
}
