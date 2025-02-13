//: [Previous](@previous)

import Foundation

// 오류 처리 패턴, 에러 핸들링
// if - else, switch - case
// do


func validateUserInput(text: String) -> Bool {
    guard !text.isEmpty else {
        print("반값")
        return false
    }
    
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        return false
    }
    
    guard checkDateFormat(text: text) else {
        print("날짜 형식이 잘못됐습니다.")
        return false
    }
    
    return true
}

func checkDateFormat(text: String) -> Bool {
    let format = DateFormatter()
    format.dateFormat = "yyyyMMdd"
    return !(format.date(from: text) == nil)
}

if validateUserInput(text: "20240101") {
    print("가능")
} else {
    print("불가")
}

enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

func validateUserInputError(text: String) throws {
    guard !text.isEmpty else {
        print("반값")
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        throw ValidationError.isNotInt
    }
    
    guard checkDateFormat(text: text) else {
        print("날짜 형식이 잘못됐습니다.")
        throw ValidationError.isNotDate
    }
}

do {
    try validateUserInputError(text: "rd")
} catch {
    print(error)
}

//: [Next](@next)
