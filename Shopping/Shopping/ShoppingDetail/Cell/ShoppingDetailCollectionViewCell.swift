//
//  ShoppingDetailCollectionViewCell.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit
import SnapKit
import RxSwift
import Kingfisher

final class ShoppingDetailCollectionViewCell: BaseCollectionViewCell {
    private let thumbnailImageView = UIImageView()
    private let mallLabel = UILabel()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    let disposeBag = DisposeBag()
    let likeButton = UIButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.isSelected = false
    }
    
    override func configureHierarchy() {
        [
            thumbnailImageView,
            mallLabel,
            titleLabel,
            priceLabel,
            likeButton
        ].forEach(contentView.addSubview)
    }
    
    override func configureLayout() {
        thumbnailImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(thumbnailImageView.snp.width)
        }
        
        mallLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(thumbnailImageView).inset(4)
            make.size.equalTo(30)
        }
    }
    
    override func configureViews() {
        thumbnailImageView.backgroundColor = .white
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.clipsToBounds = true
        
        mallLabel.font = .systemFont(ofSize: 12)
        mallLabel.textColor = .systemGray
        
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .lightGray
        titleLabel.numberOfLines = 2
        
        priceLabel.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
        
        likeButton.setImage(
            UIImage(systemName: "heart"),
            for: .normal
        )
        likeButton.setImage(
            UIImage(systemName: "heart.fill"),
            for: .selected
        )
        likeButton.clipsToBounds = true
        likeButton.layer.masksToBounds = true
        likeButton.backgroundColor = .white
        likeButton.tintColor = .red
        likeButton.layer.cornerRadius = 15
        likeButton.alpha = 0.9
    }
}

//MARK: Configure
extension ShoppingDetailCollectionViewCell {
    func configure(_ content: ShoppingItem) {
        thumbnailImageView.kf.setImage(with: URL(string: content.image))
        mallLabel.text = content.mallName
        titleLabel.text = content.title
        priceLabel.text = Int(content.lprice)?.formatted()
        likeButton.isSelected = content.like
    }
}
