//
//  ArticleCell.swift
//  StayPositive
//
//  Created by Evyn Gonzalez  on 12/24/18.
//  Copyright © 2018 Stay+. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

   
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
   
    @IBOutlet weak var author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
