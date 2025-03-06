//
//  FolderRepository.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/5/25.
//

import Foundation
import RealmSwift

protocol FolderRepository {
    func createItem(name: String)
    func fetchAll() -> Results<Folder>
    func deleteItem(data: Folder)
    func createMemo(data: Folder)
}

final class FolderTableRepository: FolderRepository {
    private let realm = try! Realm()
    
    func createItem(name: String) {
        do {
            try realm.write {
                let folder = Folder(name: name)
                realm.add(folder)
            }
        } catch {
            print("Folder 저장 실패")
        }
    }
    
    func fetchAll() -> Results<Folder> {
        return realm.objects(Folder.self)
    }
    
    func deleteItem(data: Folder) {
        do {
            try realm.write {
                realm.delete(data.detail)
                realm.delete(data)
            }
        } catch {
            print("Folder 삭제 실패")
        }
    }
    
    func createMemo(data: Folder) {
        do {
            try realm.write {
                let memo = Memo()
                memo.content = "폴더의 메모 내용을 넣어주세요"
                memo.regDate = Date()
                memo.editDate = Date()
                data.memo = memo
                realm.add(data, update: .modified)
            }
        } catch {
            print("Folder 삭제 실패")
        }
    }
}
