//
//  ShoppingFilterCollectionViewCell.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit

final class ShoppingFilterCollectionViewCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            filterLabel.textColor = isSelected ? .black : .white
            backgroundColor = isSelected ? .white : .black
        }
    }
    static let identifier = "ShoppingFilterCollectionViewCell"
    private let filterLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Design
extension ShoppingFilterCollectionViewCell {
    func configureHierarchy() {
        contentView.addSubview(filterLabel)
    }
    
    func configureLayout() {
        filterLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
    }
    
    func configureViews() {
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
