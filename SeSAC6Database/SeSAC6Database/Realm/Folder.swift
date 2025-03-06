//
//  Folder.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/5/25.
//

import Foundation
import RealmSwift

class Memo: EmbeddedObject {
    @Persisted var content: String
    @Persisted var regDate: Date
    @Persisted var editDate: Date
}

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var favorite: Bool
    @Persisted var nameDescription: String
    
    @Persisted var detail: List<UserTable>
    @Persisted var memo: Memo?
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
