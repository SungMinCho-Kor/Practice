//
//  WishRepository.swift
//  Shopping
//
//  Created by 조성민 on 3/5/25.
//

import RealmSwift

protocol WishRepository {
    func fetchAll() -> Results<Wish>
    func createItem(content: String, folder: Folder)
    func deleteItem(item: Wish)
    func fetchListInFolder(folder: Folder) -> Results<Wish>
}

final class WishTableRepository: WishRepository {
    private let realm = try! Realm()
    
    func fetchListInFolder(folder: Folder) -> Results<Wish> {
        return realm.objects(Wish.self)
            .where { $0.folder == folder }
    }
    
    func fetchAll() -> Results<Wish> {
        return realm.objects(Wish.self)
    }
    
    func createItem(content: String, folder: Folder) {
        do {
            try realm.write {
                let wish = Wish(content: content)
                folder.detail.append(wish)
                realm.add(folder, update: .modified)
            }
        } catch {
            print(#function, "실패")
        }
    }
    
    func deleteItem(item: Wish) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(#function, "실패")
        }
    }
}
