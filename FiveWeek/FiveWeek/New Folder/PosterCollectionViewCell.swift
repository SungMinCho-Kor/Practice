//
//  PosterCollectionViewCell.swift
//  FiveWeek
//
//  Created by 조성민 on 1/24/25.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {
    static let id = "PosterCollectionViewCell"
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        posterImageView.backgroundColor = .systemMint
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
