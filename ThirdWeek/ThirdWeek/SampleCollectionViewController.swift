//
//  SampleCollectionViewController.swift
//  ThirdWeek
//
//  Created by 조성민 on 1/9/25.
//

import UIKit

class SampleCollectionViewController: UIViewController {
    var list: [Int] = Array(1...99)
    var showingList: [Int] = Array(1...99)
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBannerCollectionView()
        configureBannerCollectionViewLayout()
        configureListCollectionViewLayout()
        configureSearchBar()
        print("1")
        DispatchQueue.main.async {
            for i in 0...20 {
                print("\(i)")
            }
        }
        print("4")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(#function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print(#function)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
}

extension SampleCollectionViewController {
    private func configureBannerCollectionView() {
        let identifier = SampleCollectionViewCell.identifier
        let xib = UINib(nibName: identifier, bundle: nil)
        bannerCollectionView.register(
            xib,
            forCellWithReuseIdentifier: identifier
        )
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        listCollectionView.register(
            xib,
            forCellWithReuseIdentifier: identifier
        )
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
    }
    
    private func configureBannerCollectionViewLayout() {
        bannerCollectionView.collectionViewLayout = UICollectionViewFlowLayout(design: true)
//        bannerCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
//        bannerCollectionView.collectionViewLayout = collectionViewLayout()
        bannerCollectionView.isPagingEnabled = true
    }
    
    private func configureListCollectionViewLayout() {
        // 정사각형인 경우
        let screenWidth = UIScreen.main.bounds.width
        let sectionInset: CGFloat = 20
        let cellSpacing: CGFloat = 10
        let cellCount: CGFloat = 4
        let cellSize = (screenWidth - (sectionInset * 2 + cellSpacing * (cellCount - 1))) / cellCount
        guard let scenedelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        scenedelegate.window?.bounds.width
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(
            width: cellSize,
            height: cellSize
        )
        layout.sectionInset = UIEdgeInsets(
            top: sectionInset,
            left: sectionInset,
            bottom: sectionInset,
            right: sectionInset
        )
        listCollectionView.collectionViewLayout = layout
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
//        searchBar.showsSearchResultsButton = true
    }
}

extension SampleCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SampleCollectionViewCell.identifier,
            for: indexPath
        ) as! SampleCollectionViewCell
        
        cell.backgroundColor = .systemRed
        cell.imageView.backgroundColor = .white
        cell.titleLabel.text = "\(showingList[indexPath.item])"
        cell.imageView.clipsToBounds = true
        
        // Cell의 drawing cycle때문에 이상하게 잡힘 -> cell의 layoutSubviews에서 실행하면 됨!
//        cell.imageView.layer.cornerRadius = cell.imageView.frame.width / 2
        
//        DispatchQueue.main.async {
//            cell.imageView.layer.cornerRadius = cell.imageView.frame.width / 2
//        }
        return cell
    }
}

extension SampleCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function, searchBar.searchTextField.text)
        
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function, searchBar.searchTextField.text)
       
        if searchText.isEmpty {
            showingList = list
        } else {
            var result: [Int] = []
            for item in list {
                if let num = Int(searchText), item == num {
                    result.append(num)
                }
            }
            showingList = result
        }
        listCollectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(#function, searchBar.searchTextField.text)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print(#function, searchBar.searchTextField.text)
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
