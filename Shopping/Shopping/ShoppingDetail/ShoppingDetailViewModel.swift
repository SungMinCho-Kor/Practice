//
//  ShoppingDetailViewModel.swift
//  Shopping
//
//  Created by 조성민 on 2/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class ShoppingDetailViewModel: ViewModel {
    struct Input {
        let cellDidTapped: ControlEvent<IndexPath>
        let prefetch: ControlEvent<[IndexPath]>
    }
    
    struct Output {
        let navigationTitle: Driver<String>
        let searchItems: Driver<[ShoppingItem]>
        let filterCells: Driver<[CollectionViewSection]>
    }
    
    private let disposeBag = DisposeBag()
    
    private let searchText: String
    private var filter = ShoppingDetailFilter.accuracy
    private var isPaginantionEnd: Bool = false
    
    init(searchText: String) {
        self.searchText = searchText
    }
    
    func transform(input: Input) -> Output {
        let navigationTitle = BehaviorRelay(value: searchText)
        let searchItems = BehaviorRelay<[ShoppingItem]>(value: [])
        let prefetchShoppingList = PublishRelay<ShoppingItemList>()
        let prefetch = BehaviorRelay(value: 1)
        let filterCells = BehaviorRelay(value: ShoppingDetailFilter.allCases.map {
            CollectionViewSection.filter(title: $0.buttonTitle, isSelected: $0 == .accuracy)
        })
        
        prefetchShoppingList
            .withUnretained(self)
            .map { owner, list in
                if list.total == list.items.count + searchItems.value.count {
                    owner.isPaginantionEnd = true
                }
                return list.items + searchItems.value
            }
            .bind(to: searchItems)
            .disposed(by: disposeBag)
        
        input.cellDidTapped
            .compactMap {
                if $0.section == 0 {
                    return $0.row
                } else {
                    return nil
                }
            }
            .compactMap { ShoppingDetailFilter(rawValue: $0) }
            .withUnretained(self)
            .flatMapLatest { owner, filter in
                owner.filter = filter
                owner.isPaginantionEnd = false
                return owner.fetchSearchItems(start: 1)
                    .catch { error in
                        return .just(
                            ShoppingItemList(
                                total: 0,
                                items: []
                            )
                        )
                    }
            }
            .map { $0.items }
            .bind(to: searchItems)
            .disposed(by: disposeBag)
        
        input.cellDidTapped
            .compactMap {
                if $0.section == 0 {
                    return $0.row
                } else {
                    return nil
                }
            }
            .compactMap { ShoppingDetailFilter(rawValue: $0) }
            .bind { filter in
                filterCells.accept(ShoppingDetailFilter.allCases.map({
                    CollectionViewSection.filter(title: $0.buttonTitle, isSelected: $0 == filter)
                }))
            }
            .disposed(by: disposeBag)
        
        input.prefetch
            .bind(with: self) { owner, indexPaths in
                if owner.isPaginantionEnd,
                   let lastIndexPath = indexPaths.last,
                   lastIndexPath.section == 0,
                   lastIndexPath.row == searchItems.value.count - 1 {
                    prefetch.accept(searchItems.value.count)
                }
            }
            .disposed(by: disposeBag)
        
        prefetch
            .withUnretained(self)
            .flatMapLatest { owner, start in
                return owner.fetchSearchItems(start: start)
                    .catch { error in
                        return .just(
                            ShoppingItemList(
                                total: 0,
                                items: []
                            )
                        )
                    }
            }
            .bind(to: prefetchShoppingList)
            .disposed(by: disposeBag)
        
        navigationTitle
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                return owner.fetchSearchItems(start: 1)
            }
            .bind(with: self) { owner, list in
                if list.items.count == list.total {
                    owner.isPaginantionEnd = true
                }
            }
            .disposed(by: disposeBag)
        
        let output = Output(
            navigationTitle: navigationTitle.asDriver(),
            searchItems: searchItems.asDriver(),
            filterCells: filterCells.asDriver()
        )
        
        return output
    }
    
    private func fetchSearchItems(start: Int) -> Single<ShoppingItemList> {
        return NetworkManager.shared.fetchShoppingList(
            form: FetchShoppingListForm(
                query: searchText,
                sort: filter.query,
                start: start
            )
        )
    }
}
