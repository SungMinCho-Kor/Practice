//
//  ShoppingInfo.swift
//  Travel
//
//  Created by 조성민 on 1/5/25.
//

struct ShoppingInfo {
    var shoppingList: [ShoppingListContent] = [
        ShoppingListContent(
            checked: true,
            title: "그립톡 구매하기",
            favorite: true
        ),
        ShoppingListContent(
            checked: false,
            title: "사이다 구매",
            favorite: false
        ),
        ShoppingListContent(
            checked: false,
            title: "아이패드 케이스 최저가 알아보기",
            favorite: true
        ),
        ShoppingListContent(
            checked: false,
            title: "양말",
            favorite: true
        )
    ]
}
