//
//  UserDefaultsManager.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import Foundation

final class UserDefaultsManager {
    private init() {}
    
    static let shared = UserDefaultsManager()
    
    enum UDKey: String {
        case imageLink
        case user
    }
    
    let ud = UserDefaults.standard
    let basicProfileImage = "https://cdn.pixabay.com/photo/2018/11/13/21/43/avatar-3814049_1280.png"
    
    var imageLink: String {
        get {
            ud.string(forKey: UDKey.imageLink.rawValue) ?? basicProfileImage
        }
        set {
            ud.setValue(newValue, forKey: UDKey.imageLink.rawValue)
        }
    }
    
    var user: [String]? {
        get {
            ud.array(forKey: UDKey.user.rawValue) as? [String]
        }
        set {
            ud.setValue(newValue, forKey: UDKey.user.rawValue)
        }
    }
}
