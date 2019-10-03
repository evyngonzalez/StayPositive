//
//  FeedItemWebViewController.swift
//  StayPositive
//
//  Created by MACBOOK on 10/2/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import UIKit
import WebKit

class FeedItemWebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    var selectedFeedURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n", with:"")
        webView.load(URLRequest(url: URL(string: selectedFeedURL! as String)!))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
    }
}
