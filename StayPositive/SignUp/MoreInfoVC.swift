//
//  MoreInfoVC.swift
//  StayPositive
//
//  Created by Irving Lopez on 8/22/17.
//  Copyright © 2017 Stay+. All rights reserved.
//

import UIKit
import Firebase

class MoreInfoVC: UIViewController {
    
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lName: UITextField!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var bDay: UITextField!
    
let picker = UIDatePicker()
    
    func createDatePicker()
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action:  #selector(donePressed))
        toolbar.setItems([done], animated: false)
        bDay.inputAccessoryView = toolbar
        bDay.inputView = picker
        
        picker.datePickerMode = .date
    
    }
    
    func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        
        
        bDay.text = "\(dateString)"
        self.view.endEditing(true)
    }
  


}
