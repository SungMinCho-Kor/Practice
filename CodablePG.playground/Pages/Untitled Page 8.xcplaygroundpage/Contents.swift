//: [Previous](@previous)

import Foundation

extension String {
    subscript(idx: Int) -> String? {
        guard (0..<count).contains(idx) else { return nil }
        return String(self[index(startIndex, offsetBy: idx)])
    }
}

let nickname = "abcd"
print(nickname[1])

struct UserPhoneList {
    var contracts = [
        "01012312323",
        "01012312324",
        "01012312325",
        "01012312326",
        "01012312327"
    ]
    subscript(idx: Int) -> String {
        get {
            return contracts[idx]
        }
        set {
            contracts[idx] = newValue
        }
    }
}

var phone = UserPhoneList()
phone[0]
phone[0] = "456"
phone[0]

//: [Next](@next)
