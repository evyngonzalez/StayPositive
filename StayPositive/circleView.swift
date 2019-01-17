//
//  circleView.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 7/13/17.
//
//

import UIKit

class circleView: UIImageView {
    
 
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true 
    }

  
}
