//
//  FeedBtn.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 7/13/17.
//
//

import UIKit

class FeedBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
     
        
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 0.5
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView?.contentMode = .scaleAspectFit
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = self.frame.width / 2

    }
    
    
    
}
