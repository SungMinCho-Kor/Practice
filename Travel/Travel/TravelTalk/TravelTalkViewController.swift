//
//  TravelTalkViewController.swift
//  Travel
//
//  Created by 조성민 on 1/10/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarDesign()
        collectionViewDesign()
        configureCollectionView()
    }
    
}

//MARK: Design
extension TravelTalkViewController {
    private func searchBarDesign() {
        searchBar.searchBarStyle = .minimal
    }
    
    private func collectionViewDesign() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            print(#function, "sceneDelegate Wrong")
            collectionView.collectionViewLayout = layout
            return
        }
        let width: CGFloat = window.bounds.width
        let height: CGFloat = 80 + 16 * 2
        layout.itemSize = CGSize(
            width: width,
            height: height
        )
        collectionView.collectionViewLayout = layout
    }
}

//MARK: Configure
extension TravelTalkViewController {
    private func configureCollectionView() {
        let identifier = TravelTalkCollectionViewCell.identifier
        let xib = UINib(
            nibName: identifier,
            bundle: nil
        )
        collectionView.register(
            xib,
            forCellWithReuseIdentifier: identifier
        )
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

//MARK: CollectionView
extension TravelTalkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        mockChatList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TravelTalkCollectionViewCell.identifier,
            for: indexPath
        ) as? TravelTalkCollectionViewCell else {
            print(#function, "TravelTalkCollectionViewCell wrong")
            return UICollectionViewCell()
        }
        
        return cell
    }
}
