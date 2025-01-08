//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"


class JackUserDefaults {
    
    var age: Int {
        get {
            UserDefaults.standard.integer(forKey: "age")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "age")
        }
//        didSet {
//            
//        }
//        willSet {
//            
//        }
    }
    
    var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "nickname") ?? "대장"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
}

let jack = JackUserDefaults()
jack.age



//: [Next](@next)
