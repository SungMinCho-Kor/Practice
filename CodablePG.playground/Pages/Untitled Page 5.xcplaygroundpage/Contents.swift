//: [Previous](@previous)

import Foundation

let json = """
{
    "product_name": "도봉캠퍼스 캠핑카",
    "price": 12345000,
    "mall_name": "네이버"
}
"""

struct Product: Encodable {
    let productName: String
    let price: Int
    let mallName: String
    let date: Date
}

let products = [
    Product(
        productName: "1",
        price: 100,
        mallName: "naver",
        date: Date()
    ),
    Product(
        productName: "2",
        price: 200,
        mallName: "toss",
        date: Date(timeInterval: -86400, since: Date())
    ),
    Product(
        productName: "133",
        price: 300,
        mallName: "kakao",
        date: Date(timeIntervalSinceNow: 86400 * 2)
    )
]

// Data -> Struct
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
//encoder.dateEncodingStrategy = .iso8601

let format = DateFormatter()
format.dateFormat = "MM월 dd일, yyyy년"

encoder.dateEncodingStrategy = .formatted(format)

do {
    let value = try encoder.encode(products)
    guard let string = String(data: value, encoding: .utf8) else { fatalError() }
    print(string)
//    dump(value)
    
} catch {
    print(error)
}
//: [Next](@next)
