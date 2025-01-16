//
//  ShoppingSearchViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit
import SnapKit

final class ShoppingSearchViewController: BaseViewController {
    private let shoppingSearchView: ShoppingSearchView
    private let searchAlertController = UIAlertController(
        title: nil,
        message: "두 글자 이상으로 검색하세요.",
        preferredStyle: .alert
    )
    
    override init() {
        self.shoppingSearchView = ShoppingSearchView()
        super.init()
    }
    
    override func loadView() {
        self.view = shoppingSearchView
    }
    
    override func configureView() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureTapped)
        )
        view.addGestureRecognizer(tapGesture)
        shoppingSearchView.searchBar.delegate = self
        
        searchAlertController.addAction(
            UIAlertAction(
                title: "확인",
                style: .default
            )
        )
    }
    
    override func configureNavigation() {
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        let backButton = UIBarButtonItem(
            title: "",
            style: .plain,
            target: self,
            action: nil
        )
        backButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
    }
}

//MARK: SearchBar
extension ShoppingSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              text.count >= 2 else {
            present(searchAlertController, animated: true)
            return
        }
        print(#function)
        view.endEditing(true)
        navigationController?.pushViewController(
            ShoppingDetailViewController(searchText: text),
            animated: true
        )
    }
}

//MARK: Objective-C
@objc
extension ShoppingSearchViewController {
    private func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
