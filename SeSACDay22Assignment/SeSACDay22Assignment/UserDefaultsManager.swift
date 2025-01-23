//
//  UserDefaultsManager.swift
//  SeSACDay22Assignment
//
//  Created by 조성민 on 1/23/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    @UserDefault(key: "isOnboardDone", defaultValue: false)
    var isOnboardDone
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
