//
//  Book.swift
//  FourthWeek
//
//  Created by 조성민 on 1/15/25.
//

struct Book: Decodable {
    var documents: [BookDetail]
    let meta: Meta
}

struct BookDetail: Decodable {
    let contents: String
    let price: Int
    let title: String
    let thumbnail: String
}

struct Meta: Decodable {
    let is_end: Bool
}
