//
//  ShoppingDetailViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import Kingfisher
import SnapKit
import UIKit

final class ShoppingDetailViewController: BaseViewController {
    private let resultCountLabel = UILabel()
    private lazy var shoppingCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    private let viewModel: ShoppingDetailViewModel

    private let input = ShoppingDetailViewModel.Input(
        changeFilter: Observable<IndexPath>(
            IndexPath(
                row: 0,
                section: 0
            )
        ),
        pagination: Observable<Bool>(true)
    )
    
    init(searchText: String) {
        viewModel = ShoppingDetailViewModel(paginationText: searchText)
        super.init()
        print("ShoppingDetailViewController Init")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        input.viewDidLoad.value = ()
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

        shoppingCollectionView.delegate = self
        shoppingCollectionView.dataSource = self
        shoppingCollectionView.prefetchDataSource = self
        shoppingCollectionView.selectItem(
            at: IndexPath(item: 0, section: 0),
            animated: false,
            scrollPosition: .left
        )

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
        let output = viewModel.transform(input: input)
        
        output.navigationTitle.bind { [weak self] title in
            self?.navigationItem.title = title
        }
        
        output.reloadData.bind { [weak self] in
            self?.shoppingCollectionView.reloadSections(IndexSet(integer: 1))
        }
        
        output.scrollToTop.bind { [weak self] in
            self?.shoppingCollectionView.scrollToItem(
                at: IndexPath(row: 0, section: 0),
                at: .top,
                animated: false
            )
        }
        
        output.resultCountLabel.bind { [weak self] text in
            self?.resultCountLabel.text = text
        }
    }
}

//MAKR: CollectionView
extension ShoppingDetailViewController: UICollectionViewDelegate,
    UICollectionViewDataSource
{
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
            return viewModel.list.count
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShoppingFilterCollectionViewCell
                        .identifier,
                    for: indexPath
                ) as? ShoppingFilterCollectionViewCell
            else {
                print(#function, "ShoppingFilterCollectionViewCell wrong")
                return UICollectionViewCell()
            }
            cell.configure(
                title: ShoppingDetailFilter.allCases[indexPath.row].buttonTitle)
            return cell
        } else {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ShoppingDetailCollectionViewCell
                        .identifier,
                    for: indexPath
                ) as? ShoppingDetailCollectionViewCell
            else {
                print(#function, "ShoppingDetailCollectionViewCell wrong")
                return UICollectionViewCell()
            }
            cell.configure(viewModel.list[indexPath.row])
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        if indexPath.section == 0 {
            input.changeFilter.value = indexPath
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        if indexPath.section == 0,
            indexPath != collectionView.indexPathsForSelectedItems?.first
        {
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
           lastIndexPath.row == viewModel.list.count - 1 {
            input.pagination.value = false
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cancelPrefetchingForItemsAt indexPaths: [IndexPath]
    ) {
        for indexPath in indexPaths {
            if let url = URL(string: viewModel.list[indexPath.row].image) {
                KingfisherManager.shared.downloader.cancel(url: url)
            }
        }
    }
}

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
