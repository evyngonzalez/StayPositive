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
    case Store
    case Social
    case General
    
    var description: String {
        switch self {
        case .Authentication: return "Authentication"
        case .Store: return "Store"
        case .Social: return "Social"
        case .General: return "General"
            
        }
    }
}


enum AuthOptions: Int, CaseIterable, SectionType {
    case changeEmail
    case changePass
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .changeEmail: return "ChangeEmailAddress"
        case .changePass: return "ChangePassword"
        }
    }
}

enum SocialOptions: Int, CaseIterable, SectionType {
    
    case inviteFriends
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .inviteFriends: return "InviteFriends"
        }
    }
}

enum StoreOptions: Int, CaseIterable, SectionType {
    
    case subscriptions
    case oneTimePurchases
    
    var containsSwitch: Bool { return false}
    
    var description: String {
        switch self {
        case .oneTimePurchases: return "Purchases"
        case .subscriptions: return "Purchases"
        }
    }
}

enum GeneralOptions: Int, CaseIterable, SectionType {
    case aboutStayPositive
    case privacyPolicy
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .aboutStayPositive: return "About"
        case .privacyPolicy: return "About"
        }
    }
}
