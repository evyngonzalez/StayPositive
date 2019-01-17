//
//  MultViewiFeedViewController.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 8/13/18.
//  Copyright © 2018 Stay+. All rights reserved.
//

import UIKit

class MultViewiFeedViewController: UIViewController {
    
    @IBOutlet var segmentedControl : UISegmentedControl!
 
    
    lazy var NewsFeedTable : NewsFeedTable = {
        let storyboard = UIStoryboard(name: "Main" , bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "NewsFeedTable") as! NewsFeedTable
        
        self.addViewCotrollerAsChildViewController(childViewController: viewController)
        
        return viewController
    }()
    
    lazy var sessionsViewController : SessionsViewController = {
        let storyboard = UIStoryboard(name: "Main" , bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SessionsViewController") as! SessionsViewController
        
        self.addViewCotrollerAsChildViewController(childViewController: viewController)
        
        return viewController
    }()
    
    lazy var thirdtoMultiViewController : ThirdtoMultiViewController = {
        let storyboard = UIStoryboard(name: "Main" , bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "ThirdtoMultiViewController") as! ThirdtoMultiViewController
        
        self.addViewCotrollerAsChildViewController(childViewController: viewController)
        
        return viewController
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }

    private func setupView() {
        setupSegmentedControl()
       
        updateView()
        
    }
    
    private func updateView() {
        
        NewsFeedTable.view.isHidden = !(segmentedControl.selectedSegmentIndex == 0)
        sessionsViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 1)
        thirdtoMultiViewController.view.isHidden = !(segmentedControl.selectedSegmentIndex == 2)

    }
    
    private func setupSegmentedControl() {
      
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "News", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Stay Positive", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Following", at: 2, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
    }
    
    func selectionDidChange(sender: UISegmentedControl) {
        updateView()
    }
    
    private func addViewCotrollerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        
        view.addSubview(childViewController.view)
        
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        childViewController.didMove(toParentViewController: self)
        
        
    }
    
    

}
