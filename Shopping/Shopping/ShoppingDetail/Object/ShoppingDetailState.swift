//
//  ShoppingDetailState.swift
//  Shopping
//
//  Created by 조성민 on 1/16/25.
//

struct ShoppingDetailState {
    let searchText: String
    var list: [ShoppingItem] = []
    var isEnd: Bool = false
    var currentFilter = ShoppingDetailFilter.accuracy
    
    init(searchText: String) {
        self.searchText = searchText
    }
}
