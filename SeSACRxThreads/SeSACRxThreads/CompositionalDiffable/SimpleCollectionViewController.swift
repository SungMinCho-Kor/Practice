//
//  SimpleCollectionViewController.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/26/25.
//

import UIKit

struct Product: Hashable {
    let name: String
    let price = Int.random(in: 1...1000)
    let count = Int.random(in: 1...20)
}

enum Section: CaseIterable {
    case main
    case sub
}

final class Cell: UICollectionViewCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(text: String) {
        label.text = text
    }
}

final class SimpleCollectionViewController: UIViewController {
    
//    private let list = ["Jack", "Bran", "Den", "Hue"]
//    private let list = [1,2,3,4,5,6,7]
    private let list = [
        Product(name: "M5"),
        Product(name: "trackpad"),
        Product(name: "keyboard"),
        Product(name: "jacket"),
        Product(name: "shoes"),
        Product(name: "gold")
    ]
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
    
//    <Section, Model>
    private var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
//        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        updateSnapShot()
    }
    //Flow -> Compositinoal -> List Configuration
    //테이블뷰 시스템 기능 기능을 컬렉션뷰로도 만들수 있어
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped) //-> 테이블뷰 시스템 기능! 가능! 만들수 있어!
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        //collectionView.register 대신
        // <Cell, Model>
        var registration = UICollectionView.CellRegistration<UICollectionViewListCell, Product> {
            cell,
            indexPath,
            itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.image = UIImage(systemName: "star")
            
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.textProperties.font = .systemFont(ofSize: 20, weight: .bold)
            
            content.secondaryText = "\(indexPath.row)"
            content.secondaryTextProperties.color = .systemBlue
            
            
            cell.contentConfiguration = content
            
            var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfiguration.backgroundColor = .systemYellow
//            backgroundConfiguration.backgroundInsets = NSDirectionalEdgeInsets(
//                top: 10,
//                leading: 0,
//                bottom: 10,
//                trailing: 0
//            )
            backgroundConfiguration.strokeWidth = 5
            backgroundConfiguration.strokeColor = .orange
            backgroundConfiguration.cornerRadius = 10
            
            cell.backgroundConfiguration = backgroundConfiguration
//            cell.configure(text: itemIdentifier.name)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .main)
        snapshot.appendItems(
            [Product(name: "afwg"), Product(name: "afwg")],
            toSection: .main
        )
        snapshot.appendItems(
            [Product(name: "afwgww"), Product(name: "afwddg")],
            toSection: .sub
        )
        dataSource.apply(snapshot)
    }
}

extension SimpleCollectionViewController: UICollectionViewDelegate/*, UICollectionViewDataSource */{
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
    
    /*
     dequeueReusableCell
     customCell + identifier + register
     
     dequeueConfigureReusableCell
     systemCell +  + CellRegistration
     */
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueConfiguredReusableCell(
//            using: registration,
//            for: indexPath,
//            item: list[indexPath.row]
//        )
//        
//        return cell
//    }
}
