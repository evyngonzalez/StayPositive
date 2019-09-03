//
//  PhoneAuthController.swift
//  StayPositive
//
//  Created by MACBOOK on 9/2/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth


class PhoneAuthController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    
    //Outlets
    
    @IBOutlet var PhoneNumberText: UITextField!
    @IBOutlet var NextButton: UIButton!
    
    
    //Variables
    
    
    
    //Constants
    
    let userDefaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        PhoneNumberText.delegate = self
        self.PhoneNumberText.addBottomBorder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        PhoneNumberText.resignFirstResponder()
        return true
    }
    
    
    
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self)
    }
//    @objc func keyboardWillShow(_ notification: Notification) {
//        if PhoneNumberText.isFirstResponder{
//            self.view.frame.origin.y -= getKeyboardHeight(notification)
//        }
//    }
//
//    @objc func keyboardWillHide(_ notification: Notification) {
//        if PhoneNumberText.isFirstResponder {
//            self.view.frame.origin.y = 0
//        }
//    }
    //Functions
    
    
    
    //Actions
    @IBAction func PhoneSignIn(_ sender: Any) {
        
        guard let phoneNumber = PhoneNumberText.text else { return }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationId, error) in
            
            if error == nil {
                //do Something useful
                print(verificationId)
                
                guard let verifyId = verificationId else { return }
                
                self.userDefaults.set(verifyId, forKey: "verificationId")
                
                self.userDefaults.synchronize()
                
                self.performSegue(withIdentifier: "phoneAuth", sender: UIViewController?.self)
                
            } else {
                print("Unable to access secret verification code", error?.localizedDescription)
            }
        }
    }
}
extension UITextField {
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}
