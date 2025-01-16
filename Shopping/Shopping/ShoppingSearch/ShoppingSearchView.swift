//
//  ShoppingSearchView.swift
//  Shopping
//
//  Created by 조성민 on 1/16/25.
//

import UIKit

final class ShoppingSearchView: BaseView {
    let searchBar = UISearchBar()
    let centerLabel = UILabel()
    
    override func configureHierarchy() {
        [
            searchBar,
            centerLabel
        ].forEach(addSubview)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(keyboardLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureViews() {
        backgroundColor = .black
        isUserInteractionEnabled = true
        
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        centerLabel.text = "쇼핑하구팡"
        centerLabel.textAlignment = .center
        centerLabel.font = .boldSystemFont(ofSize: 24)
    }
}
