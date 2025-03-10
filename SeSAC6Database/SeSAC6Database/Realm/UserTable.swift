//
//  UserTable.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/4/25.
//

import Foundation
import RealmSwift

class UserTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId // PK 는 자동으로 index 기능이 들어있다, pk : 중복 X, null X
    @Persisted var money: Int
    @Persisted var category: String
    @Persisted(indexed: true) var name: String // index 설정으로 빠르게 검색 가능
    @Persisted var isIncome: Bool
    @Persisted var memo: String?
    @Persisted var date: Date
    @Persisted var like: Bool
    
    @Persisted var poster: Data
    
    @Persisted(originProperty: "detail")
    var folder: LinkingObjects<Folder>
    
    convenience init(
        money: Int,
        category: String,
        name: String,
        isIncome: Bool,
        memo: String? = nil
    ) {
        self.init()
        self.money = money
        self.category = category
        self.name = name
        self.isIncome = isIncome
        self.memo = memo
        self.date = Date()
        self.like = false
    }
}
