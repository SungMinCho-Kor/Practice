//
//  SectionModel.swift
//  Shopping
//
//  Created by 조성민 on 2/25/25.
//

import RxDataSources

enum CollectionViewSection {
    case filter(title: String, isSelected: Bool)
    case cell(item: ShoppingItem)
}

struct ModelSection {
    var items: [CollectionViewSection]
}

extension ModelSection: SectionModelType {
    typealias Item = CollectionViewSection

    init(original: ModelSection, items: [Item]) {
        self = original
        self.items = items
    }
}
