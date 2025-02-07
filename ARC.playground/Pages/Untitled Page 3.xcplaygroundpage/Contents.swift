//: [Previous](@previous)

import Foundation

func plus(num: Int) -> (() -> Int) {
    var total = 0
    
    func calculate() -> Int {
        return total + num
    }
    
    return calculate
}

let a = plus(num: 10)
a()
a()
a()
a()

func firstClosure() {
    var number = 0
    
    print ("1", number)
    
    var myClosure1 = { [number] in
        print("myClosure", number)
    }
    
    var myClosure2 = {
        print("myClosure", number)
    }
    
    number = 100
    
    myClosure1()
    myClosure2()
    
    print("2", number)
}

firstClosure()

//: [Next](@next)
