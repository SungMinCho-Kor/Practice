//
//  WishRepository.swift
//  Shopping
//
//  Created by 조성민 on 3/5/25.
//

import RealmSwift

protocol WishRepository {
    func fetchAll() -> Results<Wish>
    func createItem(content: String)
}

final class WishTableRepository: WishRepository {
    private let realm = try! Realm()
    
    func fetchAll() -> Results<Wish> {
        return realm.objects(Wish.self)
    }
    
    func createItem(content: String) {
        do {
            try realm.write {
                realm.add(Wish(content: content))
            }
        } catch {
            print(#function, "실패")
        }
    }
}
