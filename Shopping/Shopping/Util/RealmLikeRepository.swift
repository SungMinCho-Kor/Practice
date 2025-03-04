//
//  RealmLikeRepository.swift
//  Shopping
//
//  Created by 조성민 on 3/4/25.
//

import RealmSwift

final class RealmLikeRepository {
    let realm = try! Realm()
    var likeList: Results<ShoppingItemModel>
    
    init() {
        likeList = realm.objects(ShoppingItemModel.self)
    }
    
    func save(item: ShoppingItemModel) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("save 실패: \(error)")
        }
    }
    
    func read(id: String) -> ShoppingItemModel? {
        return realm.object(
            ofType: ShoppingItemModel.self,
            forPrimaryKey: id
        )
    }
    
    func update(item: ShoppingItemModel) {
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print("update 실패: \(error)")
        }
    }
    
    func delete(item: ShoppingItemModel) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("delete 실패: \(error)")
        }
    }
}

final class ShoppingItemModel: Object {
    @Persisted(primaryKey: true) var productId: String
    @Persisted(indexed: true) var title: String
    @Persisted var image: String
    @Persisted var lprice: String
    @Persisted var mallName: String
    
    convenience init(
        productId: String,
        title: String,
        image: String,
        lprice: String,
        mallName: String
    ) {
        self.init()
        self.productId = productId
        self.title = title
        self.image = image
        self.lprice = lprice
        self.mallName = mallName
    }
    
    func toItem() -> ShoppingItem {
        return ShoppingItem(
            productId: productId,
            title: title,
            image: image,
            lprice: lprice,
            mallName: mallName,
            like: true
        )
    }
}
