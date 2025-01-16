//
//  FetchShoppingListForm.swift
//  Shopping
//
//  Created by 조성민 on 1/16/25.
//

struct FetchShoppingListForm: Encodable {
    let query: String
    let display: Int = 30
    let sort: String
    let start: Int
}
