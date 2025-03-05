//
//  Folder.swift
//  Shopping
//
//  Created by 조성민 on 3/5/25.
//

import RealmSwift

final class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var detail: List<Wish>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
