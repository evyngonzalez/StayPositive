//
//  messageDetailcell.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 8/12/17.
//
//

import UIKit

class messageDetailcell: UITableViewCell {
    
    @IBOutlet weak var recipientImg: UIImageView!
    @IBOutlet weak var recipientName: UILabel!
    @IBOutlet weak var chatPreview: UILabel!

    //var messageDetail : MessageDetail!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
