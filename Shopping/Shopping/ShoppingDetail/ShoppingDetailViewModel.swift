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
        let prefetch = PublishRelay<Int>()
        
        input.cellDidTapped
            .distinctUntilChanged()
            .compactMap {
                if $0.section == 0 {
                    return $0.row
                } else {
                    return nil
                }
            }
            .withUnretained(self)
            .flatMapLatest { owner, row in
                owner.isPaginantionEnd = false
                return owner.fetchSearchItems(start: 1)
                    .catch { error in
                        return .just([])
                    }
            }
            .bind(to: searchItems)
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
                        return .just([])
                    }
            }
            .bind(with: self) { owner, newItems in
                var items = searchItems.value
                items.append(contentsOf: newItems)
                searchItems.accept(items)
            }
            .disposed(by: disposeBag)
        
        navigationTitle
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                return owner.fetchSearchItems(start: 1)
            }
            .bind(to: searchItems)
            .disposed(by: disposeBag)
        
        let output = Output(
            navigationTitle: navigationTitle.asDriver(),
            searchItems: searchItems.asDriver()
        )
        
        return output
    }
    
    private func fetchSearchItems(start: Int) -> Single<[ShoppingItem]> {
        return NetworkManager.shared.fetchShoppingList(
            form: FetchShoppingListForm(
                query: searchText,
                sort: filter.query,
                start: start
            )
        )
        .map { $0.items }
    }
}
