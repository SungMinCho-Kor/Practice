//
//  Book.swift
//  FourthWeek
//
//  Created by 조성민 on 1/15/25.
//

struct Book: Decodable {
    let documents: [BookDetail]
}

struct BookDetail: Decodable {
    let contents: String
    let price: Int
    let title: String
    let thumbnail: String
}
