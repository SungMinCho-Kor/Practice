//: [Previous](@previous)

import Foundation

class Mobile {
    var name: String
    var nickname: String = "arㄷ"
    
    var introduce: String {
        get {
            "당신의 \(name) 제품을 구매했고, 구매 날짜는 \(Date())입니다."
        }
        set {
            name = newValue
            
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    func buy() {
        print("구매했습니다.")
    }
}

class Google: Mobile {
    
    override func buy() {
        super.buy()
        print("Google을~")
    }
    
}

class Apple: Mobile {
    let wwdc = "WWDC"
}

let phone = Mobile(name: "PHONE")

phone.name

let google = Google(name: "GOOGLE")

let apple = Apple(name: "APPLE")
apple.name
apple.wwdc

phone is Mobile
phone is Google
phone is Apple

google is Mobile
google is Google
google is Apple

apple is Mobile
apple is Google
apple is Apple

var iPhone: Mobile = Apple(name: "APPLE")

iPhone = Google(name: "dfgh")

if let phone = iPhone as? Apple {
    
}

var somethings: [Any] = []
somethings.append(apple)
somethings.append("asdasd")
somethings.append(3)

for something in somethings {
    print(type(of: something))
}

if let element = somethings[0] as? Google {
    element.name
} else if let element = somethings[0] as? Apple {
    element.wwdc
}
//: [Next](@next)
