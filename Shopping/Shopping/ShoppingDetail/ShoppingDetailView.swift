//
//  ShoppingDetailView.swift
//  Shopping
//
//  Created by 조성민 on 1/16/25.
//

import UIKit

final class ShoppingDetailView: BaseView {
    var state: ShoppingDetailState
    let resultCountLabel = UILabel()
    lazy var shoppingCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    init(searchText: String) {
        self.state = ShoppingDetailState(searchText: searchText)
        super.init()
    }
    
    override func configureHierarchy() {
        [
            resultCountLabel,
            shoppingCollectionView
        ].forEach(addSubview)
    }
    
    override func configureLayout() {
        resultCountLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        shoppingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureViews() {
        backgroundColor = .black
        
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
    }
}

extension ShoppingDetailView {
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
