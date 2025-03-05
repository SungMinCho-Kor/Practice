//
//  FolderRepository.swift
//  Shopping
//
//  Created by 조성민 on 3/5/25.
//

import RealmSwift

protocol FolderRepository {
    func fetchAll() -> Results<Folder>
    func createFolder(name: String)
}

final class FolderTableRepository: FolderRepository {
    private let realm = try! Realm()
    
    func fetchAll() -> Results<Folder> {
        return realm.objects(Folder.self)
    }
    
    func createFolder(name: String) {
        do {
            try realm.write {
                realm.add(Folder(name: name))
            }
        } catch {
            print(#function, "실패")
        }
    }
}
