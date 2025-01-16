//
//  ShoppingDetailViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

final class ShoppingDetailViewController: BaseViewController {
    private var state: ShoppingDetailState
    private let resultCountLabel = UILabel()
    private lazy var shoppingCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    init(searchText: String) {
        self.state = ShoppingDetailState(searchText: searchText)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchShoppingList(filter: state.currentFilter, start: 1)
    }
    
    override func configureHierarchy() {
        [
            resultCountLabel,
            shoppingCollectionView
        ].forEach(view.addSubview)
        
        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        shoppingCollectionView.prefetchDataSource = self
    }
    
    override func configureLayout() {
        resultCountLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        shoppingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureViews() {
        view.backgroundColor = .black
        
        resultCountLabel.font = .systemFont(ofSize: 14)
        resultCountLabel.textColor = .systemGreen
        
        shoppingCollectionView.register(
            ShoppingDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: ShoppingDetailCollectionViewCell.identifier
        )
        shoppingCollectionView.register(
            ShoppingFilterCollectionViewCell.self,
            forCellWithReuseIdentifier: ShoppingFilterCollectionViewCell.identifier
        )
        shoppingCollectionView.selectItem(
            at: IndexPath(item: 0, section: 0),
            animated: false,
            scrollPosition: .left
        )
    }
    
    override func configureNavigation() {
        navigationItem.title = state.searchText
    }
}

//MARK: Design
extension ShoppingDetailViewController {
    private func collectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(100),
                    heightDimension: .estimated(44)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(100),
                    heightDimension: .estimated(44)
                )
                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.orthogonalScrollingBehavior = .continuous
                return section
            } else {
                guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                      let window = sceneDelegate.window else {
                    print(#function, "SceneDelegate Wrong")
                    return nil
                }
                let sectionInset: CGFloat = 10
                let itemSpacing: CGFloat = 12
                let width = (window.bounds.width - sectionInset * 2 - itemSpacing) / 2
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(width),
                    heightDimension: .absolute(width + 100)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(window.bounds.width - sectionInset * 2),
                    heightDimension: .absolute(width + 100)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item, item]
                )
                group.interItemSpacing = NSCollectionLayoutSpacing.fixed(itemSpacing)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: sectionInset,
                    leading: sectionInset,
                    bottom: sectionInset,
                    trailing: sectionInset
                )
                section.interGroupSpacing = 10
                return section
            }
        }
    }
}

// MARK: API
extension ShoppingDetailViewController {
    private func fetchShoppingList(filter: ShoppingDetailFilter, start: Int) {
        if start == 1 {
            state.isEnd = false
        }
        if !state.isEnd {
            let url = "https://openapi.naver.com/v1/search/shop.json?query=\(state.searchText)&display=30&sort=\(filter.query)&start=\(start)"
            let header = HTTPHeaders([
                "X-Naver-Client-Id": APIKey.naverClientID,
                "X-Naver-Client-Secret": APIKey.naverSecretKey
            ])
            AF.request(url, method: .get, headers: header)
                .validate()
                .responseDecodable(of: ShoppingItemList.self) { response in
                    switch response.result {
                    case .success(let list):
                        if start != 1 {
                            self.state.list.append(contentsOf: list.items)
                        } else {
                            self.state.list = list.items
                        }
                        self.state.isEnd = list.total < start + 30
                        self.resultCountLabel.text = "\(list.total.formatted()) 개의 검색 결과"
                        self.shoppingCollectionView.reloadSections(IndexSet(integer: 1))
                        if start == 1 {
                            self.shoppingCollectionView.scrollToItem(
                                at: IndexPath(row: 0, section: 0),
                                at: .top,
                                animated: false
                            )
                        }
                    case .failure(let error):
                        dump(error)
                    }
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
            return state.list.count
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
            cell.configure(state.list[indexPath.row])
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if indexPath.section == 0 {
            state.currentFilter = ShoppingDetailFilter.allCases[indexPath.row]
            fetchShoppingList(filter: state.currentFilter, start: 1)
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
           (state.list.count-10...state.list.count-1).contains(lastIndexPath.row) {
            fetchShoppingList(filter: state.currentFilter, start: state.list.count)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cancelPrefetchingForItemsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            if let url = URL(string: state.list[indexPath.row].image) {
                KingfisherManager.shared.downloader.cancel(url: url)
            }
        }
    }
}
