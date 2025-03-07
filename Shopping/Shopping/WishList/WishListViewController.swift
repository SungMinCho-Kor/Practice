//
//  WishListViewController.swift
//  Shopping
//
//  Created by 조성민 on 2/26/25.
//

import UIKit
import SnapKit
import RealmSwift

final class WishListViewController: BaseViewController {
    enum Section {
        case main
    }
    
    private let repository: WishRepository = WishTableRepository()
    private var list: Results<Wish>!
    
    private let textField = UITextField()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Wish>!
    private let folder: Folder
    
    init(folder: Folder) {
        self.folder = folder
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataBase()
        configureDataSource()
        updateSnapShot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    private func setDataBase() {
        list = repository.fetchListInFolder(folder: folder)
    }
    
    override func configureHierarchy() {
        [
            textField,
            collectionView
        ].forEach(view.addSubview)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(52)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview().inset(8)
        }
    }
    
    override func configureViews() {
        view.backgroundColor = .black
        textField.placeholder = "위시리스트를 입력하세요"
        textField.borderStyle = .line
        textField.autocorrectionType = .no
        textField.delegate = self
        
        collectionView.delegate = self
    }
    
    override func configureNavigation() {
        navigationItem.title = folder.name
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.separatorConfiguration.bottomSeparatorInsets = .zero
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Wish> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.image = UIImage(systemName: "star.fill")
            
            content.text = itemIdentifier.content
            content.textProperties.color = .white
            content.textProperties.font = .systemFont(ofSize: 16, weight: .bold)
            
            content.secondaryText = itemIdentifier.date.formatted(
                date: .numeric,
                time: .shortened
            )
            content.secondaryTextProperties.color = .white
            content.secondaryTextProperties.font = .systemFont(ofSize: 12)
            
            var backgroundConfiguration = UIBackgroundConfiguration.listCell()
            backgroundConfiguration.backgroundColor = .darkGray
            
            cell.contentConfiguration = content
            cell.backgroundConfiguration = backgroundConfiguration
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: registration,
                for: indexPath,
                item: itemIdentifier
            )
            return cell
        }
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Wish>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(Array(list), toSection: .main)
        dataSource.apply(snapshot)
    }
}

extension WishListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            print(#function, "No Text")
            return true
        }
        repository.createItem(content: text, folder: folder)
        updateSnapShot()
        textField.text = ""
        return true
    }
}

extension WishListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        repository.deleteItem(item: list[indexPath.row])
        updateSnapShot()
    }
}
