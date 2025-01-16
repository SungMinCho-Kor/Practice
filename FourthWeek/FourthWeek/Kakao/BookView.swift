//
//  BookView.swift
//  FourthWeek
//
//  Created by 조성민 on 1/16/25.
//

import UIKit

class BookView: BaseView {
    
    lazy var collectionView = createCollectionView()
    
    let list = Array<Int>(1...1000)
    
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return collectionView
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 50, height: 50)
        return layout
    }

}

extension BookView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return list.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "BookCollectionViewCell",
            for: indexPath
        ) as? BookCollectionViewCell else {
            print(#function, "BookCollectionViewCell wrong")
            return UICollectionViewCell()
        }
        cell.bookCoverImageView.image = UIImage.remove
        return cell
    }
}
