//
//  ShoppingFilterCollectionViewCell.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit

final class ShoppingFilterCollectionViewCell: BaseCollectionViewCell {
    override var isSelected: Bool {
        didSet {
            filterLabel.textColor = isSelected ? .black : .white
            backgroundColor = isSelected ? .white : .black
        }
    }
    private let filterLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(filterLabel)
    }
    
    override func configureLayout() {
        filterLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
    override func configureViews() {
        filterLabel.textColor = .white
        backgroundColor = .black
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 0.8
        layer.borderColor = UIColor.white.cgColor
    }
}

//MARK: Configure
extension ShoppingFilterCollectionViewCell {
    func configure(title: String) {
        filterLabel.text = title
    }
}
