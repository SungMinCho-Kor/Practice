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
}
