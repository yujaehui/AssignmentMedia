//
//  UserDefaultsManager.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import Foundation

class UserDefaultsManager {
    private init() {}
    
    static let shared = UserDefaultsManager()
    
    enum UDKey: String {
        case user
    }
    
    let ud = UserDefaults.standard
    var user: [String]? {
        get {
            ud.array(forKey: UDKey.user.rawValue) as? [String]
        }
        set {
            ud.setValue(newValue, forKey: UDKey.user.rawValue)
        }
    }
}
