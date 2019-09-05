//
//  SettingsSection.swift
//  StayPositive
//
//  Created by MACBOOK on 9/3/19.
//  Copyright © 2019 Stay+. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case Authentication
    case General
    case Store
    
    var description: String {
        switch self {
        case .Authentication: return "Authentication"
        case .General: return "General"
        case .Store: return "Store"
            
        }
    }
}


enum AuthOptions: Int, CaseIterable, SectionType {
    case changeEmail
    case changePass
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .changeEmail: return "Change Email Address"
        case .changePass: return "Change Password"
        }
    }
}

enum StoreOptions: Int, CaseIterable, SectionType {
    
    case subscriptions
    case oneTimePurchases
    
    var containsSwitch: Bool { return false}
    
    var description: String {
        switch self {
        case .oneTimePurchases: return "One Time Purchases"
        case .subscriptions: return "Subscriptions"
        }
    }
}

enum GeneralOptions: Int, CaseIterable, SectionType {
    case notifications
    case email
    case reportCrashes
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .notifications: return "Notifications"
        case .email: return "Email"
        case .reportCrashes: return "Report Crashes"
        }
    }
}
