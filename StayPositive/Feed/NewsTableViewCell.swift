//
//  NewsTableViewCell.swift
//  StayPositive
//
//  Created by Evyn Gonzalez  on 12/28/18.
//  Copyright © 2018 Stay+. All rights reserved.
//

import UIKit
enum CellState {
    case expanded
    case collapsed
}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! {
    didSet {
    descriptionLabel.numberOfLines = 2
    }
        
    }

    @IBOutlet weak var dateLabel: UILabel!
    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            dateLabel.text = item.pubDate
        }
    }
}


