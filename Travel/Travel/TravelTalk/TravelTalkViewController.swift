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
    
    private var showingList: [ChatRoom] = mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDesign()
        searchBarDesign()
        collectionViewDesign()
        configureCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
}

//MARK: Design
extension TravelTalkViewController {
    private func navigationDesign() {
        let backButton = UIBarButtonItem(
            title: nil,
            style: .plain,
            target: self,
            action: nil
        )
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }
    
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
        guard let cellContent = showingList[indexPath.row].travelTalkCollectionViewCellContent else {
            print(#function, "CellContent wrong")
            return cell
        }
        cell.configure(cellContent)
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let chatViewController = storyboard?.instantiateViewController(identifier: ChatViewController.identifier) as? ChatViewController else {
            print(#function, "ChatViewController wrong")
            return
        }
        chatViewController.navigationItem.title = showingList[indexPath.row].chatroomName
        chatViewController.list = showingList[indexPath.row].chatList
        let navigationController = UINavigationController(rootViewController: chatViewController)
        navigationController.modalPresentationStyle = .fullScreen
        view.window?.layer.add(
            CATransition().pushFromLeft(),
            forKey: kCATransition
        )
        present(
            navigationController,
            animated: false
        )
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
            showingList = mockChatList
        } else {
            showingList = mockChatList.filter({
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
