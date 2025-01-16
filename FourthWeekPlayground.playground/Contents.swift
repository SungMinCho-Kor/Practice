import UIKit

/*
 first class object 일급객체
 1. 변수, 상수에 함수를 사용할 수 있다.
 2. 인자값에 사용할 수 있다.
 3. 반환값에 사용할 수 있다.
 
 Function Type
 자료형이 함수의 형태를 띄는 것
 */

func introduce(nickname: String) -> String {
    return "저는 \(nickname) 입니다."
}

func introduce(name: String) -> String {
    return "나는 \(name) 입니다."
}

func introduce() -> String {
    return "안녕하세요"
}

func introduce() {
    print("안녕하세요")
}

let jack1: () = introduce() // String
//let jack2: (String) -> String = introduce(name: "")   // () -> String

func oddNumber() {
    
}

func evenNumber() {
    
}

func resultNumber(value: Int) {
    if value.isMultiple(of: 2) {
        print("짝수")
    } else {
        print("홀수")
    }
}

let bran = { make in
    return "a"
}
