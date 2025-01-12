//
//  TravelTalkViewController.swift
//  Travel
//
//  Created by 조성민 on 1/10/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var collectionView: UICollectionView!
    
    private var showingList: [ChatRoom] = mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarDesign()
        collectionViewDesign()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
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
        let firstIdentifier = TravelTalkOneCollectionViewCell.identifier
        let firstXIB = UINib(
            nibName: firstIdentifier,
            bundle: nil
        )
        collectionView.register(
            firstXIB,
            forCellWithReuseIdentifier: firstIdentifier
        )
        
        let secondIdentifier = TravelTalkTwoCollectionViewCell.identifier
        let secondXIB = UINib(
            nibName: secondIdentifier,
            bundle: nil
        )
        collectionView.register(
            secondXIB,
            forCellWithReuseIdentifier: secondIdentifier
        )
        
        let thirdIdentifier = TravelTalkThreeCollectionViewCell.identifier
        let thirdXIB = UINib(
            nibName: thirdIdentifier,
            bundle: nil
        )
        collectionView.register(
            thirdXIB,
            forCellWithReuseIdentifier: thirdIdentifier
        )
        
        let fourthidentifier = TravelTalkFourCollectionViewCell.identifier
        let fourthXIB = UINib(
            nibName: fourthidentifier,
            bundle: nil
        )
        collectionView.register(
            fourthXIB,
            forCellWithReuseIdentifier: fourthidentifier
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
        if showingList[indexPath.row].chatroomImage.count == 1 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TravelTalkOneCollectionViewCell.identifier,
                for: indexPath
            ) as? TravelTalkOneCollectionViewCell else {
                print(#function, "TravelTalkOneCollectionViewCell wrong")
                return UICollectionViewCell()
            }
            guard let cellContent = showingList[indexPath.row].travelTalkOneCollectionViewCellContent else {
                print(#function, "travelTalkOneCollectionViewCellContent wrong")
                return cell
            }
            cell.configure(cellContent)
            
            return cell
        } else if showingList[indexPath.row].chatroomImage.count == 2 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TravelTalkTwoCollectionViewCell.identifier,
                for: indexPath
            ) as? TravelTalkTwoCollectionViewCell else {
                print(#function, "TravelTalkTwoCollectionViewCell wrong")
                return UICollectionViewCell()
            }
            guard let cellContent = showingList[indexPath.row].travelTalkTwoCollectionViewCellContent else {
                print(#function, "travelTalkTwoCollectionViewCellContent wrong")
                return cell
            }
            cell.configure(cellContent)
            
            return cell
        } else if showingList[indexPath.row].chatroomImage.count == 3 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TravelTalkThreeCollectionViewCell.identifier,
                for: indexPath
            ) as? TravelTalkThreeCollectionViewCell else {
                print(#function, "TravelTalkThreeCollectionViewCell wrong")
                return UICollectionViewCell()
            }
            guard let cellContent = showingList[indexPath.row].travelTalkThreeCollectionViewCellContent else {
                print(#function, "travelTalkThreeCollectionViewCellContent wrong")
                return cell
            }
            cell.configure(cellContent)
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TravelTalkFourCollectionViewCell.identifier,
                for: indexPath
            ) as? TravelTalkFourCollectionViewCell else {
                print(#function, "TravelTalkFourCollectionViewCell wrong")
                return UICollectionViewCell()
            }
            guard let cellContent = showingList[indexPath.row].travelTalkFourCollectionViewCellContent else {
                print(#function, "travelTalkFourCollectionViewCellContent wrong")
                return cell
            }
            cell.configure(cellContent)
            
            return cell
        }
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
        chatViewController.chatRoomID = showingList[indexPath.row].chatroomId
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
