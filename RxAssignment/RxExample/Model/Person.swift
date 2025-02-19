//
//  Person.swift
//  RxExample
//
//  Created by 조성민 on 2/19/25.
//

import Foundation

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let profileImage: String
}
