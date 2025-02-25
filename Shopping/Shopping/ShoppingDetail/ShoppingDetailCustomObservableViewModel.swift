//
//  ShoppingDetailCustomObservableViewModel.swift
//  Shopping
//
//  Created by 조성민 on 2/6/25.
//

import Foundation

final class ShoppingDetailCustomObservableViewModel: ViewModel {
    struct Input {
        let changeFilter: Observable<IndexPath>
        let pagination: Observable<Bool>
        let viewDidLoad: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let resultCountLabel: Observable<String> = Observable("")
        let reloadData: Observable<Void> = Observable(())
        let scrollToTop: Observable<Void> = Observable(())
        let navigationTitle: Observable<String> = Observable("")
    }
    
    private let paginationText: String
    private var isEnd: Bool = false
    var list: [ShoppingItem] = []
    
    init(paginationText: String) {
        self.paginationText = paginationText
        print("ShoppingDetailViewModel Init")
    }
    
    deinit {
        print("ShoppingDetailViewModel Deinit")
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        input.changeFilter.bind { [weak self] indexPath in
            if indexPath.section == 0 {
                let nextFilter = ShoppingDetailFilter.allCases[indexPath.row]
                self?.isEnd = false
                self?.list = []
                self?.fetchList(
                    isFilterChanged: true,
                    filter: nextFilter,
                    output: output
                )
            }
        }
        
        input.pagination.lazyBind { [weak self] isFilterChanged in
            guard let self else { return }
            if isEnd {
                return
            }
            let filter = ShoppingDetailFilter.allCases[input.changeFilter.value.row]
            fetchList(
                isFilterChanged: isFilterChanged,
                filter: filter,
                output: output
            )
        }
        
        input.viewDidLoad.bind { [weak self] _ in
            guard let self else { return }
            output.navigationTitle.value = paginationText
        }
        
        return output
    }
    
    private func fetchList(
        isFilterChanged: Bool,
        filter: ShoppingDetailFilter,
        output: Output
    ) {
        NetworkManager.shared.fetchShoppingList(
            form: FetchShoppingListForm(
                query: paginationText,
                sort: filter.query,
                start: isFilterChanged ? 1 : list.count
            )
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let list):
                self.isEnd = list.total < self.list.count + 30
                self.list.append(contentsOf: list.items)
                output.resultCountLabel.value = "\(list.total.formatted()) 개의 검색 결과"
                output.reloadData.value = ()
                if isFilterChanged {
                    output.scrollToTop.value = ()
                }
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
