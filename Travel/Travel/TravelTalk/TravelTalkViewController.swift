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
    
    let list: [TravelTalkCollectionViewCellContent] = mockChatList.compactMap({ $0.travelTalkCollectionViewCellContent })
    var showingList: [TravelTalkCollectionViewCellContent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarDesign()
        collectionViewDesign()
        configureCollectionView()
        configureShowingList()
    }
}

//MARK: Design
extension TravelTalkViewController {
    private func searchBarDesign() {
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.placeholder = "채팅방 이름을 입력하세요"
        searchBar.delegate = self
    }
    
    private func collectionViewDesign() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
    
    private func configureShowingList() {
        showingList = list
    }
}

//MARK: CollectionView
extension TravelTalkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return showingList.count
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
        cell.configure(showingList[indexPath.row])
        
        return cell
    }
}

//MARK: SearchBar
extension TravelTalkViewController: UISearchBarDelegate {
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {
        let text = searchText.replacingOccurrences(
            of: " ",
            with: ""
        )
        if text.isEmpty {
            showingList = list
        } else {
            showingList = list.filter({
                $0.chatroomName
                    .lowercased()
                    .replacingOccurrences(
                        of: " ", 
                        with: ""
                    )
                    .contains(text.lowercased())
            })
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
