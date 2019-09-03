//
//  SettingsController.swift
//  StayPositive
//
//  Created by MACBOOK on 9/3/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth


class SettingsController: UIViewController {
    
    @IBOutlet var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    @IBAction func Logout(_ sender: Any) {
        logout()
    }
    
}
