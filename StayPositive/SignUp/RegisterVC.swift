//
//  RegisterVC.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 6/2/17.
//
//

import UIKit
import Firebase
import Foundation


class RegisterVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    var databaseRef = Database.database().reference()
    
    @IBAction func signUpTapped(_ sender: Any) {
        //Create user
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            if error != nil{
                //Print a message for success
                self.errorMessage.textColor = UIColor.red
                self.errorMessage.text = error?.localizedDescription
            } else {
                self.errorMessage.textColor = UIColor.green
                self.errorMessage.text = "Registered Successfully"
                //Sign In the user
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion:
                    { (user, error) in
                        if error == nil{
                            //Make entry in database
                            self.databaseRef.child("users").child(user!.user.uid).child("email").setValue(self.email.text!)
                            //Perform segue to success
                            self.performSegue(withIdentifier: "signUp", sender: nil)
                        }
                })
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
