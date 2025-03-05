//
//  Wish.swift
//  Shopping
//
//  Created by 조성민 on 3/5/25.
//

import Foundation
import RealmSwift

final class Wish: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var content: String
    @Persisted var date: Date
    @Persisted(originProperty: "detail")
    var folder: LinkingObjects<Folder>
    
    convenience init(content: String) {
        self.init()
        self.content = content
        self.date = Date()
    }
}
