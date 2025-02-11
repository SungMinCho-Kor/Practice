//: [Previous](@previous)

import Foundation

let json = """
{
    "product_name": "도봉캠퍼스 캠핑카",
    "price": 12345000,
    "mall_name": "네이버"
}
"""

struct Product: Decodable {
    let productName: String
    let price: Int
    let mallName: String
}

// String -> Data
guard let result = json.data(using: .utf8) else {
    fatalError("변환 실패")
}

// Data -> Struct
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
do {
    let value = try decoder.decode(Product.self, from: result)
    dump(value)
} catch {
    print(error)
}
