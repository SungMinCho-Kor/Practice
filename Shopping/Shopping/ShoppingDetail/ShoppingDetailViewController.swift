//
//  ShoppingDetailViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit
import SnapKit
import Kingfisher

final class ShoppingDetailViewController: BaseViewController {
    private let shoppingDetailView: ShoppingDetailView
    
    init(searchText: String) {
        self.shoppingDetailView = ShoppingDetailView(searchText: searchText)
        super.init()
    }
    
    override func loadView() {
        view = shoppingDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await fetchShoppingList(filter: shoppingDetailView.state.currentFilter, start: 1)
        }
    }
    
    override func configureNavigation() {
        navigationItem.title = shoppingDetailView.state.searchText
    }
    
    override func configureView() {
        shoppingDetailView.shoppingCollectionView.delegate = self
        shoppingDetailView.shoppingCollectionView.dataSource = self
        shoppingDetailView.shoppingCollectionView.prefetchDataSource = self
        shoppingDetailView.shoppingCollectionView.selectItem(
            at: IndexPath(item: 0, section: 0),
            animated: false,
            scrollPosition: .left
        )
    }
}

// MARK: API
extension ShoppingDetailViewController {
    private func fetchShoppingList(filter: ShoppingDetailFilter, start: Int) async {
        if start == 1 {
            shoppingDetailView.state.isEnd = false
        }
        if !shoppingDetailView.state.isEnd {
            do {
                let list = try await NetworkManager.shared.fetchShoppingList(
                    form: FetchShoppingListForm(
                        query: shoppingDetailView.state.searchText,
                        sort: filter.query,
                        start: start
                    )
                )
                if start != 1 {
                    self.shoppingDetailView.state.list.append(contentsOf: list.items)
                } else {
                    self.shoppingDetailView.state.list = list.items
                }
                self.shoppingDetailView.state.isEnd = list.total < start + 30
                self.shoppingDetailView.resultCountLabel.text = "\(list.total.formatted()) 개의 검색 결과"
                self.shoppingDetailView.shoppingCollectionView.reloadSections(IndexSet(integer: 1))
                if start == 1 {
                    self.shoppingDetailView.shoppingCollectionView.scrollToItem(
                        at: IndexPath(row: 0, section: 0),
                        at: .top,
                        animated: false
                    )
                }
            } catch {
                dump(error)
            }
        }
    }
}

//MAKR: CollectionView
extension ShoppingDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 0 {
            return ShoppingDetailFilter.allCases.count
        } else {
            return shoppingDetailView.state.list.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShoppingFilterCollectionViewCell.identifier,
                for: indexPath
            ) as? ShoppingFilterCollectionViewCell else {
                print(#function, "ShoppingFilterCollectionViewCell wrong")
                return UICollectionViewCell()
            }
            cell.configure(title: ShoppingDetailFilter.allCases[indexPath.row].buttonTitle)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ShoppingDetailCollectionViewCell.identifier,
                for: indexPath
            ) as? ShoppingDetailCollectionViewCell else {
                print(#function, "ShoppingDetailCollectionViewCell wrong")
                return UICollectionViewCell()
            }
            cell.configure(shoppingDetailView.state.list[indexPath.row])
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if indexPath.section == 0 {
            shoppingDetailView.state.currentFilter = ShoppingDetailFilter.allCases[indexPath.row]
            Task {
                await fetchShoppingList(filter: shoppingDetailView.state.currentFilter, start: 1)
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        if indexPath.section == 0,
            indexPath != collectionView.indexPathsForSelectedItems?.first {
            return true
        } else {
            return false
        }
    }
}

extension ShoppingDetailViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(
        _ collectionView: UICollectionView,
        prefetchItemsAt indexPaths: [IndexPath]
    ) {
        if let lastIndexPath = indexPaths.last,
           lastIndexPath.section == 1,
           (shoppingDetailView.state.list.count-10...shoppingDetailView.state.list.count-1).contains(lastIndexPath.row) {
            Task {
                await fetchShoppingList(filter: shoppingDetailView.state.currentFilter, start: shoppingDetailView.state.list.count)
            }
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cancelPrefetchingForItemsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            if let url = URL(string: shoppingDetailView.state.list[indexPath.row].image) {
                KingfisherManager.shared.downloader.cancel(url: url)
            }
        }
    }
}
