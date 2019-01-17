//
//  LoginVC.swift
//  StayPositive
//
//  Created by Irving Lopez on 8/22/17.
//  Copyright © 2017 Stay+. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBut: UIButton!
    
    
    @IBAction func loginTapped(_ sender: Any) {
       //firebase login
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
