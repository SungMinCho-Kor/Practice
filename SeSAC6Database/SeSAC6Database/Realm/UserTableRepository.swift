//
//  UserTableRepository.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/5/25.
//

import Foundation
import RealmSwift

protocol UserRepository {
    func getFileURL()
    func fetchAll() -> Results<UserTable>
    func createItem()
    func createItemInFolder(folder: Folder, data: UserTable)
    func deleteItem(data: UserTable)
    func updateItem(data: UserTable)
}

final class UserTableRepository: UserRepository {
    
    private let realm = try! Realm()
    
    func getFileURL() {
        print(realm.configuration.fileURL)
    }
    
    func fetchAll() -> Results<UserTable> {
        return realm.objects(UserTable.self)
            .sorted(byKeyPath: "money", ascending: false)
    }
    
    func createItem() {
        do {
            try realm.write {
                let data = UserTable(
                    money: Int.random(in: 10...100) * 1000,
                    category: ["생활비", "카페", "식비"].randomElement()!,
                    name: ["빵", "커피", "돈까스"].randomElement()!,
                    isIncome: false,
                    memo: nil
                )
                realm.add(data)
            }
        } catch {
            print("업데이트 실패")
        }
    }
    
    func createItemInFolder(folder: Folder, data: UserTable) {
        do {
            try realm.write {
                folder.detail.append(data)
            }
        } catch {
            print("업데이트 실패")
        }
    }
    
    func deleteItem(data: UserTable) {
        do {
            try realm.write {
                realm.delete(data)
            }
        } catch {
            print("삭제 실패")
        }
    }
    
    func updateItem(data: UserTable) {
        do {
            try realm.write {
                realm.create(
                    UserTable.self,
                    value: [
                        "id": data.id,
                        "money": 1000000000
                    ],
                    update: .modified
                )
            }
        } catch {
            print("업데이트 실패")
        }
    }
}
