//
//  BookViewController.swift
//  FourthWeek
//
//  Created by 조성민 on 1/13/25.
//

import UIKit
import SnapKit

class BookViewController: UIViewController {
    
    let list = Array<Int>(1...1000)
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            BookCollectionViewCell.self,
            forCellWithReuseIdentifier: "BookCollectionViewCell"
        )
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
