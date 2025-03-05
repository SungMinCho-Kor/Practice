//
//  Folder.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/5/25.
//

import RealmSwift

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var detail: List<UserTable>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
