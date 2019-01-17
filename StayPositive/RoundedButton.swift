//
//  RoundedButton.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 11/13/17.
//  Copyright © 2017 Stay+. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1/UIScreen.main.nativeScale
        layer.borderColor = UIColor.white.cgColor
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
    }
}
