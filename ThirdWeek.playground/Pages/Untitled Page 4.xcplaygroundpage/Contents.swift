//: [Previous](@previous)

import UIKit

var greeting: String

greeting = "Hello"

greeting

class BMI {
    var weight: Double
    var height: Double
    
    var bmiResult: String {
        get {
            let value = (weight * weight) / height / 100.0
            let result = value < 25 ? "저체중" : "정상 이상"
            return "bmi 수치는 \(value)로, \(result)입니다."
        }
    }
    
    init(weight: Double, height: Double) {
        self.weight = weight
        self.height = height
    }
}

let bmi = BMI(weight: 73, height: 1.7)

print(bmi.bmiResult)

class Movie {
    let title: String
    let runtime: Int
    lazy var video = Video() // 지연 저장 프로퍼티
//    static lazy var video2 = Video()
    
    init(title: String, runtime: Int) {
        self.title = title
        self.runtime = runtime
        print("Movie init")
    }
}

class Video {
    var file = UIImage(systemName: "star")
    
    init() {
        print("Video init")
    }
}

let media = Movie(title: "오징어게임2", runtime: 134)
media.video
var media22: Movie? = Movie(title: "오오게", runtime: 123)
media22
media22?.video
media22?.video.file
// 클래스 인스턴스가 생성되면 인스턴스 내부에 각각의 인스턴스 메서드와 인스턴스 프로퍼티가 존재함. (공간을 차지)
// 타입 프로퍼티, 타입 메서드는 공통의 공간을 차지하기 때문에 Monster 인스턴스가 계속 생성되어도 공간을 더 차지하지 않는다.
// 타입 프로퍼티는 호출하지 않으면 메모리 공간을 차지하지 않는다.
// 하지만 호출시 앱의 종료 전에 영구적으로 메모리 공간을 차지한다.
// 인스턴스 프로퍼티는 nil을 넣어 줌으로써 메모리 공간을 해제할 수 있다.
// 궁금중 : ARC에서는 어떻게 처리할까
class Monster {
    static let game: String = "카트라이더" // 타입 프로퍼티 : 클래스 자체의 프로퍼티, 인스턴스화 하지 않고 초기화하지 않아도 사용할 수 있음. (+ Meta type에서 옴)
    // 저장과 연산으로 따지면, 타입 저장 프로퍼티!
    let clothes: String // 인스턴스 프로퍼티 : 담기고 난 후 초기화 후에 사용할 수 있음.
    // 저장과 연산으로 따지면, 인스턴스 저장 프로퍼티!
    let speed: Int
    let exp: Int
    
    init(clothes: String, speed: Int, exp: Int) {
        self.clothes = clothes
        self.speed = speed
        self.exp = exp
    }
    
    func attack() { // 인스턴스 메서드 : 초기화 이후에 사용할 수 있음.
        print("공격!")
    }
    
    static func ment() { // 타입 메서드 : 클래스 자체의 프로퍼티, 인스턴스화 하지 않고 초기화하지 않아도 사용할 수 있음. (+ Meta type에서 옴)
        print("아악..")
    }
    
}

// Optional로 선언하여 nil로 초기화하면 차지하고 있는 공간을 없앨 수 있다.
var easy: Monster? = Monster(clothes: "red", speed: 1, exp: 1)
easy?.clothes
easy?.speed
easy?.exp
easy = nil
easy
easy?.speed

var hard: Monster? = Monster(clothes: "yellow", speed: 100, exp: 100)
hard?.clothes
hard?.speed
hard?.exp

Monster.game
Monster.ment()

//: [Next](@next)


