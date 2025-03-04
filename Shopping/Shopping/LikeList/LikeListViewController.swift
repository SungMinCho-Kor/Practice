//
//  LikeListViewController.swift
//  Shopping
//
//  Created by 조성민 on 3/4/25.
//

import UIKit
import SnapKit
import RealmSwift
import Toast

final class LikeListViewController: BaseViewController {
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createColectionViewLayout()
    )
    
    private let likeRepository = RealmLikeRepository()
    
    override func configureHierarchy() {
        [
            searchBar,
            collectionView
        ].forEach(view.addSubview)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.keyboardLayoutGuide)
        }
    }
    
    override func configureViews() {
        navigationItem.title = "좋아요 리스트"
        
        searchBar.searchBarStyle = .minimal
        
        collectionView.keyboardDismissMode = .onDrag
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            ShoppingDetailCollectionViewCell.self,
            forCellWithReuseIdentifier: ShoppingDetailCollectionViewCell.identifier
        )
    }
    
    private func createColectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(
            top: 10,
            left: 10,
            bottom: 10,
            right: 10
        )
        
        return layout
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        likeRepository.delete(item: likeRepository.likeList[sender.tag])
        collectionView.reloadData()
        view.makeToast(
            "상품을 좋아요 목록에서 삭제했습니다",
            duration: 2,
            position: .bottom
        )
    }
}

extension LikeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return likeRepository.likeList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShoppingDetailCollectionViewCell.identifier,
            for: indexPath
        ) as? ShoppingDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(likeRepository.likeList[indexPath.row].toItem())
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(
            self,
            action: #selector(likeButtonTapped),
            for: .touchUpInside
        )
        
        return cell
    }
}

extension LikeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.bounds.width - 32) / 2
        return CGSize(
            width: width,
            height: width + 100
        )
    }
}
