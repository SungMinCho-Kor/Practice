//
//  ShoppingDetailViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit
import Kingfisher
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class ShoppingDetailViewController: BaseViewController {
    private let disposeBag = DisposeBag()
    private let viewModel: ShoppingDetailViewModel
    
    private let resultCountLabel = UILabel()
    private lazy var shoppingCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    init(viewModel: ShoppingDetailViewModel) {
        self.viewModel = viewModel
        super.init()
        print("ShoppingDetailViewController Init")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    deinit {
        print("ShoppingDetailViewController Deinit")
    }
    
    override func configureHierarchy() {
        [
            resultCountLabel,
            shoppingCollectionView,
        ].forEach(view.addSubview)
    }

    override func configureViews() {
        view.backgroundColor = .black
        
        resultCountLabel.font = .systemFont(ofSize: 14)
        resultCountLabel.textColor = .systemGreen

        shoppingCollectionView.register(
            ShoppingDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: ShoppingDetailCollectionViewCell
                .identifier
        )
        shoppingCollectionView.register(
            ShoppingFilterCollectionViewCell.self,
            forCellWithReuseIdentifier: ShoppingFilterCollectionViewCell
                .identifier
        )
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
    
    private func bind() {
        let output = viewModel.transform(
            input: ShoppingDetailViewModel.Input(
                cellDidTapped: shoppingCollectionView.rx.itemSelected,
                prefetch: shoppingCollectionView.rx.prefetchItems
            )
        )
        
        output.navigationTitle
            .drive(with: self) { owner, value in
                owner.navigationItem.title = value
            }
            .disposed(by: disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<ModelSection> { dataSource, collectionView, indexPath, item in
            switch item {
            case .filter(let title, let isSelected):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingFilterCollectionViewCell.identifier, for: indexPath) as? ShoppingFilterCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(title: title)
                // Cell의 isSelected가 작동하지 않네요...ㅠㅠ
                cell.isSelected = isSelected
                
                return cell
            case .cell(let cellItem):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShoppingDetailCollectionViewCell.identifier, for: indexPath) as? ShoppingDetailCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(cellItem)
                
                return cell
            }
        }
        
        Observable.combineLatest(
            output.filterCells.asObservable(),
            output.searchItems.asObservable()
        )
        .map {
            [
                ModelSection(items: $0.0),
                ModelSection(items: $0.1.map { CollectionViewSection.cell(item: $0 )})
            ]
        }
        .bind(to: shoppingCollectionView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}

//MAKR: CollectionView
//extension ShoppingDetailViewController: UICollectionViewDelegate,
//    UICollectionViewDataSource
//{
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        numberOfItemsInSection section: Int
//    ) -> Int {
//        if section == 0 {
//            return ShoppingDetailFilter.allCases.count
//        } else {
//            return viewModel.list.count
//        }
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath
//    ) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//            guard
//                let cell = collectionView.dequeueReusableCell(
//                    withReuseIdentifier: ShoppingFilterCollectionViewCell
//                        .identifier,
//                    for: indexPath
//                ) as? ShoppingFilterCollectionViewCell
//            else {
//                print(#function, "ShoppingFilterCollectionViewCell wrong")
//                return UICollectionViewCell()
//            }
//            cell.configure(
//                title: ShoppingDetailFilter.allCases[indexPath.row].buttonTitle)
//            return cell
//        } else {
//            guard
//                let cell = collectionView.dequeueReusableCell(
//                    withReuseIdentifier: ShoppingDetailCollectionViewCell
//                        .identifier,
//                    for: indexPath
//                ) as? ShoppingDetailCollectionViewCell
//            else {
//                print(#function, "ShoppingDetailCollectionViewCell wrong")
//                return UICollectionViewCell()
//            }
//            cell.configure(viewModel.list[indexPath.row])
//            return cell
//        }
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        didSelectItemAt indexPath: IndexPath
//    ) {
//        if indexPath.section == 0 {
//            input.changeFilter.value = indexPath
//        }
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        shouldSelectItemAt indexPath: IndexPath
//    ) -> Bool {
//        if indexPath.section == 0,
//            indexPath != collectionView.indexPathsForSelectedItems?.first
//        {
//            return true
//        } else {
//            return false
//        }
//    }
//}

//extension ShoppingDetailViewController: UICollectionViewDataSourcePrefetching {
//    func collectionView(
//        _ collectionView: UICollectionView,
//        prefetchItemsAt indexPaths: [IndexPath]
//    ) {
//        if let lastIndexPath = indexPaths.last,
//           lastIndexPath.section == 1,
//           lastIndexPath.row == viewModel.list.count - 1 {
//            input.pagination.value = false
//        }
//    }
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        cancelPrefetchingForItemsAt indexPaths: [IndexPath]
//    ) {
//        for indexPath in indexPaths {
//            if let url = URL(string: viewModel.list[indexPath.row].image) {
//                KingfisherManager.shared.downloader.cancel(url: url)
//            }
//        }
//    }
//}

extension ShoppingDetailViewController {
    private func collectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout {
            (sectionIndex, _) -> NSCollectionLayoutSection? in
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
                guard
                    let sceneDelegate = UIApplication.shared.connectedScenes
                        .first?.delegate as? SceneDelegate,
                    let window = sceneDelegate.window
                else {
                    print(#function, "SceneDelegate Wrong")
                    return nil
                }
                let sectionInset: CGFloat = 10
                let itemSpacing: CGFloat = 12
                let width =
                    (window.bounds.width - sectionInset * 2 - itemSpacing) / 2
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(width),
                    heightDimension: .absolute(width + 100)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(
                        window.bounds.width - sectionInset * 2),
                    heightDimension: .absolute(width + 100)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item, item]
                )
                group.interItemSpacing = NSCollectionLayoutSpacing.fixed(
                    itemSpacing)
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
