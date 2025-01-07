//
//  TenCollectionViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

class TenCollectionViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDesign()
    }
    
    private func collectionViewDesign() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "TenCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "TenCollectionViewCell"
        )
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(
            top: 100,
            left: 50,
            bottom: 100,
            right: 50
        )
        
        collectionView.collectionViewLayout = layout
    }
    
}

extension TenCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TenCollectionViewCell",
            for: indexPath
        ) as? TenCollectionViewCell else {
            print("TenCollectionViewCell wrong identifier")
            return UICollectionViewCell()
        }
//        cell.postImageView.image = UIImage(systemName: "star")
        
        return cell
    }
}
