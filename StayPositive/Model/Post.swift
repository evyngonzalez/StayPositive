//
//  Post.swift
//  StayPositive
//
//  Created by MACBOOK on 9/26/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit

struct  Post {
    var coverImage: UIImage?
    var audioURL: String?
    var time: String?
    var videoURL: String?
    var postTitle: String?
    
    
    init(data: NSDictionary) {
        coverImage = data["coverImage"] as? UIImage
        audioURL = data["audioURL"] as? String
        time = data["time"] as? String
        videoURL = data["videoURL"] as? String
        postTitle = data["postTitle"] as? String
    }
}
