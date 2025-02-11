//: [Previous](@previous)

import Foundation

let json = """
{
    "product": "도봉캠퍼스 캠핑카",
    "price": 12345000,
    "mall": "네이버"
}
"""

struct Product: Decodable {
    let item: String
    let price: Int
    let mall: String
    let influencer: Bool

    enum CodingKeys: String, CodingKey {
        case item = "product"
        case price
        case mall
    }
    
    // 커스텀 디코딩 : 서버에서 주지 않아도 나머지에 의해 정해지도록 구현할 수 있음
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item = try container.decode(String.self, forKey: .item)
        
        price = try container.decodeIfPresent(Int.self, forKey: .price) ?? 0 // 뷰에서 처리하지 않고 미리 데이터에서 옵셔널을 처리해줄 수 있음
        
        mall = try container.decode(String.self, forKey: .mall)
        influencer = (10000000...20000000).contains(price) ? true : false
    }
}

// String -> Data
guard let result = json.data(using: .utf8) else {
    fatalError("변환 실패")
}

// Data -> Struct
do {
    let value = try JSONDecoder().decode(Product.self, from: result)
    dump(value)
} catch {
    print(error)
}

//: [Next](@next)
