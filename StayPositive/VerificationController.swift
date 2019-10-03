//
//  VerificationController.swift
//  StayPositive
//
//  Created by MACBOOK on 9/2/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class VerificationController: UIViewController {
    
    //Outlets
    
    @IBOutlet var CodeText: UITextField!
    @IBOutlet var VerifyButton: UIButton!
    
    //Variables
    
    //Constants
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Functions
    
    //Actions
    @IBAction func VerifyOTP(_ sender: Any) {
        
        guard let verificationCode = CodeText.text else { return }
        
        guard let verificationId = userDefaults.string(forKey: "verificationId") else { return }
        
        let credentials = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credentials) { (success, error) in
            if error == nil {
                print(success ?? "Error in code")
                print("User Signed in successfully")
                self.performSegue(withIdentifier: "codeCorrect", sender: UIViewController?.self)
            } else {
                print("something went wrong. \(error?.localizedDescription ?? "Error in code")")
            }
        }
        
    }
    
    
    
}
