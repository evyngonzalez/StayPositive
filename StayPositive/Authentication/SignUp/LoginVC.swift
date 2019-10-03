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

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBut: UIButton!
    
    override func viewDidLoad() {
        self.hideKeyboardWhenTappedAround()
        email.delegate = self
        password.delegate = self
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        email.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        //firebase login
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion:
            { (user, error) in
                if error == nil{
                    //Perform segue
                    self.performSegue(withIdentifier: "loginToHome", sender: nil)
                }
                else {
                    let alertController = UIAlertController(title: "Failed to Login", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            })
            
        }
    
    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

