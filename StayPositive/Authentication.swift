//
//  Authentication.swift
//  StayPositive
//
//  Created by MACBOOK on 9/5/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase


class Authentication: UIViewController {
    
    @IBOutlet var InfoText: UITextField!
    @IBOutlet var SendButton: UIButton!
    @IBOutlet var CancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var databaseRef = Database.database().reference()
    let user = Auth.auth().currentUser
    var credential: AuthCredential?

    @IBAction func Send(_ sender: Any) {
        
        if credential != nil {
            user?.reauthenticate(with: credential!, completion: { (nil, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Succesful Email Reset")
                Auth.auth().currentUser?.updateEmail(to: self.InfoText.text!) { (error) in
                }
            }
        })
        } else {
            print("An error happened buddy. Credentials must be nil or something")
            let forgotPasswordAlert = UIAlertController(title: "Enter credentials", message: "Enter email address and password", preferredStyle: .alert)
            forgotPasswordAlert.addTextField { (textField) in
                textField.placeholder = "Enter email address"
            }
            forgotPasswordAlert.addTextField (configurationHandler:{ (passwordText) in
                passwordText.placeholder = "Enter Password"
                passwordText.isSecureTextEntry = true

            })
            
            forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            forgotPasswordAlert.addAction(UIAlertAction(title: "Login", style: .default, handler: { (action) in
                let resetEmail = forgotPasswordAlert.textFields![0].text
                let password = forgotPasswordAlert.textFields![1].text
                
                Auth.auth().signIn(withEmail: resetEmail!, password: password! ){ (user, error) in
                    if error != nil {
                        let resetFailedAlert = UIAlertController(title: "Login Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                        resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(resetFailedAlert, animated: true, completion: nil)
                    } else {
                        Auth.auth().currentUser?.updateEmail(to: self.InfoText.text!)
                        let resetEmailSentAlert = UIAlertController(title: "Logged in Succesfully", message: "Email address changed", preferredStyle: .alert)
                        resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(resetEmailSentAlert, animated: true, completion: nil)
                    }
                }
            }))
            self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
}
    
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
