//
//  CompositionalViewController.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/27/25.
//

import UIKit

final class CompositionalViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    private var list = [1,2,3,4,5]
    private var list2 = [1,2,4,5,6,7,8]
    
    enum Section: CaseIterable {
        case first
        case second
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureDataSource()
        updateSnapShot()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // Compositional Layout 설정
    private func createLayout() -> UICollectionViewLayout {
//        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        configuration.showsSeparators = false
//        configuration.backgroundColor = .systemPurple
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        return layout
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(0.5)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // Cell 등록, Cell For Item A
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.subtitleCell()
            content.text = "\(itemIdentifier)"
            content.image = UIImage(systemName: "star")
            cell.contentConfiguration = content
            print("Cell Registration \(itemIdentifier)")
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: registration, for: indexPath, item: itemIdentifier
            )
            print("Cell DataSource \(itemIdentifier)")
            return cell
        }
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .first)
        snapshot.appendItems(list2, toSection: .second)
        dataSource.apply(snapshot)
    }
}
