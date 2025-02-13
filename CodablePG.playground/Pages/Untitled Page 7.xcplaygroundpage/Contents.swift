//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Decimal {
    var money: String
    private(set) var projectedValue = ""
    var wrappedValue: String {
        get {
            return Int(money)!.formatted() + "원"
        }
        set {
            money = newValue
            projectedValue = "당신이 이체한 금액은 \(newValue)입니다."
        }
    }
}

struct Example {
    @Decimal(money: "7000")
    var number
}

var ex = Example()
ex.number
ex.$number

ex.number = "168000"
ex.number
ex.$number


//: [Next](@next)
