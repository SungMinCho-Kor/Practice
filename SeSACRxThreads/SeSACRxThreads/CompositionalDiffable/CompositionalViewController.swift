//
//  CompositionalViewController.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/27/25.
//

import UIKit
import RxSwift
import RxCocoa

final class CompositionalViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    private var list = Array(10000...10100)
    private var list2 = Array(0...100)
    
    enum Section: CaseIterable {
        case first
        case second
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureDataSource()
        updateSnapShot()
        multiUnicast()
    }
    
    private let disposeBag = DisposeBag()
    
    
    // Observable(unicast), Subject(multicast)
    private func multiUnicast() {
//        let sampleInt = Observable<Int>.create { observer in
//            observer.onNext(Int.random(in: 0...100))
//            return Disposables.create()
//        }
        
//        let sampleInt = BehaviorSubject(value: 0)
//        sampleInt.onNext(Int.random(in: 0...100))
        
//        let sampleInt = Observable<Int>.just(10)
        let sampleInt = Observable<Int>.of(1, 2, 3)
        
        sampleInt
            .subscribe { value in
                print("1", value)
            }
            .disposed(by: disposeBag)
        
        sampleInt
            .subscribe { value in
                print("2", value)
            }
            .disposed(by: disposeBag)
        
        sampleInt
            .subscribe { value in
                print("3", value)
            }
            .disposed(by: disposeBag)
        
        
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // Compositional Layout 설정
//    private func createLayout() -> UICollectionViewLayout {
////        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
////        configuration.showsSeparators = false
////        configuration.backgroundColor = .systemPurple
////        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
////        return layout
//        
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.5),
//            heightDimension: .fractionalHeight(1.0)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(
//            top: 5,
//            leading: 5,
//            bottom: 5,
//            trailing: 5
//        )
//        
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .absolute(300),
//            heightDimension: .absolute(100)
//        )
//        
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: groupSize,
//            subitems: [item]
//        )
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 20
//        section.orthogonalScrollingBehavior = .groupPagingCentered
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        
//        return layout
//    }
    
    // Group 안에 Group - 중첩 그룹)
//    private func createLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .fractionalHeight(1/3)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(
//            top: 5,
//            leading: 5,
//            bottom: 5,
//            trailing: 5
//        )
//        
//        let innerGroupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1/3),
//            heightDimension: .fractionalHeight(1.0)
//        )
//        
//        let innerGroup = NSCollectionLayoutGroup.vertical(
//            layoutSize: innerGroupSize,
//            subitems: [item]
//        )
//        
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .absolute(300),
//            heightDimension: .absolute(100)
//        )
//        
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: groupSize,
//            subitems: [innerGroup]
//        )
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 20
//        section.orthogonalScrollingBehavior = .groupPagingCentered
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        
//        return layout
//    }
    
    // 섹션 별 다른 레이아웃
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1/3)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5
                )
        
                let innerGroupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1.0)
                )
        
                let innerGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: innerGroupSize,
                    subitems: [item]
                )
        
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(300),
                    heightDimension: .absolute(100)
                )
        
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [innerGroup]
                )
        
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1.0)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 5,
                    leading: 5,
                    bottom: 5,
                    trailing: 5
                )
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(300),
                    heightDimension: .absolute(100)
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 20
                section.orthogonalScrollingBehavior = .groupPagingCentered
                
                return section
            }
        }
        return layout
    }
    
    // Cell 등록, Cell For Item A
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<CompositionalCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
//            var content = UIListContentConfiguration.subtitleCell()
//            content.text = "\(itemIdentifier)"
//            content.image = UIImage(systemName: "star")
            cell.configure(text: "\(itemIdentifier)")
//            print("Cell Registration \(itemIdentifier)")
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: registration, for: indexPath, item: itemIdentifier
            )
//            print("Cell DataSource \(itemIdentifier)")
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
