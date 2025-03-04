//
//  ShoppingItem.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

struct ShoppingItemList: Decodable {
    let total: Int
    let items: [ShoppingItem]
}

struct ShoppingItem: Decodable {
    let title: String
    let image: String
    let lprice: String
    let mallName: String
    var like: Bool
    
    enum CodingKeys: CodingKey {
        case title
        case image
        case lprice
        case mallName
        case like
    }
    
    init(from decoder: any Decoder) throws {
        self.title = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .title)
        self.image = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .image)
        self.lprice = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .lprice)
        self.mallName = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .mallName)
        self.like = false// TODO: 수정
    }
}
