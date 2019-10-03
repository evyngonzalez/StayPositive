//
//  newFirstLastGen.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 5/21/18.
//  Copyright © 2018 Stay+. All rights reserved.
//

import UIKit
import AVFoundation

class newFirstLastGen: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
   
    @IBOutlet weak var bDay: UITextField!
    @IBOutlet weak var Gender: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    
    
    
    
    
    var list = ["Female", "Male", "Non-Binary"]
    
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.Gender.text = self.list[row]
        self.dropDown.isHidden = true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.Gender {
            self.dropDown.isHidden = false
            //if you dont want the users to se the keyboard type:
            
            textField.endEditing(true)
        }
        
    }
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        
        datePicker.addTarget(self, action: #selector(newFirstLastGen.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
       
        bDay.inputView = datePicker
       
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        toolbar.barStyle = UIBarStyle.blackTranslucent
        toolbar.tintColor = UIColor.white
        
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(newFirstLastGen.donePressed(sender:)))
        
        toolbar.setItems([doneButton], animated: true)
        bDay.inputAccessoryView = toolbar
        
        
       // background video
        let URL = Bundle.main.url(forResource: "backgvid" , withExtension: "mov")
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        Player = AVPlayer.init(url: URL!)
        PlayerLayer = AVPlayerLayer(player: Player)
        PlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        PlayerLayer.frame = view.layer.frame
        Player.volume = 0
        
        
        Player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        Player.play()
        
        view.layer.insertSublayer(PlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: Player.currentItem)
        
    }


@objc func playerItemReachEnd(notification: NSNotification) {
    Player.seek(to:CMTime.zero)
    
}
    
    @objc func donePressed(sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        bDay.resignFirstResponder()
    
    
    }
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        bDay.text = formatter.string(from: sender.date)
    }
    
}


