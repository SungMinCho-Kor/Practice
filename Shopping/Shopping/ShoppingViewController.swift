//
//  ShoppingViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit
import SnapKit

final class ShoppingViewController: UIViewController {
    private let searchBar = UISearchBar()
    private let centerLabel = UILabel()
    private let searchAlertController = UIAlertController(
        title: nil,
        message: "두 글자 이상으로 검색하세요.",
        preferredStyle: .alert
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureViews()
        configureNavigation()
    }
}

//MARK: Design
extension ShoppingViewController: ViewConfiguration {
    func configureHierarchy() {
        [
            searchBar,
            centerLabel
        ].forEach(view.addSubview)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureViews() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureTapped)
        )
        view.backgroundColor = .black
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        centerLabel.text = "쇼핑하구팡"
        centerLabel.textAlignment = .center
        centerLabel.font = .boldSystemFont(ofSize: 24)
        
        searchAlertController.addAction(
            UIAlertAction(
                title: "확인",
                style: .default
            )
        )
    }
    
    @objc
    private func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func configureNavigation() {
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

extension ShoppingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              text.count >= 2 else {
            present(searchAlertController, animated: true)
            return
        }
        view.endEditing(true)
        navigationController?.pushViewController(
            ShoppingDetailViewController(searchText: text),
            animated: true
        )
    }
}
