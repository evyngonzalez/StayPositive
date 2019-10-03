//
//  theTableViewController.swift
//  StayPositive
//
//  Created by Evyn Gonzalez on 6/21/17.
//
//

import UIKit

class SymptomsVC: UITableViewController{
   
    let helpSought = [ "Depression", "Stress/Anxiety" , "Addiction", "PTSD" , "Marriage Counseling" , "Other (just looking to Stay Positive)"]
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(helpSought.count)
    }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = helpSought [indexPath.row]
        cell.textLabel?.textColor = UIColor.white        
                return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .checkmark
        // cell.accessoryView.hidden = false // if using a custom image
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.accessoryType = .none
        // cell.accessoryView.hidden = true  // if using a custom image
        tableView.allowsMultipleSelection = true
    }



}

    


   



