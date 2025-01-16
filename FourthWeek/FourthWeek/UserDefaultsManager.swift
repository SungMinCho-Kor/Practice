//
//  UserDefaultsManager.swift
//  FourthWeek
//
//  Created by 조성민 on 1/16/25.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    var age: Int {
        get {
            UserDefaults.standard.integer(forKey: "age")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "age")
        }
    }
    
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "name") ?? "대장"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
}
