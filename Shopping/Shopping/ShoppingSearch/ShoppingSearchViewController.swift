//
//  ShoppingSearchViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit
import SnapKit

final class ShoppingSearchViewController: BaseViewController {
//    private let viewModel = ShoppingSearchCustomObservableViewModel()
    
    private let searchBar = UISearchBar()
    private let centerLabel = UILabel()
    
    // MARK: INPUT
//    private var input = ShoppingSearchCustomObservableViewModel.Input(searchButtonClicked: Observable<String?>(nil))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        bind()
    }
    
    override func configureHierarchy() {
        [
            searchBar,
            centerLabel
        ].forEach(view.addSubview)
    }
    
    override func configureLayout() {
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
    
    override func configureViews() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureTapped)
        )
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .black
        
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.delegate = self
        
        centerLabel.text = "쇼핑하구팡"
        centerLabel.textAlignment = .center
        centerLabel.font = .boldSystemFont(ofSize: 24)
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
    
//    private func bind() {
//        let output = viewModel.transform(input: input)
//        
//        output.presentAlert.lazyBind { [weak self] _ in
//            self?.presentAlert(
//                title: nil,
//                message: "두 글자 이상으로 검색하세요.",
//                actionTitle: "확인"
//            )
//        }
//        
//        output.pushDetailViewController.lazyBind { [weak self] searchText in
//            self?.view.endEditing(true)
//            self?.navigationController?.pushViewController(
//                ShoppingDetailViewController(),
//                animated: true
//            )
//        }
//    }
}

//MARK: SearchBar
extension ShoppingSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        input.searchButtonClicked.value = searchBar.text
    }
}

//MARK: Objective-C
@objc
extension ShoppingSearchViewController {
    private func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
