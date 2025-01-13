//
//  BookCollectionViewCell.swift
//  FourthWeek
//
//  Created by 조성민 on 1/13/25.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    let bookCoverImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bookCoverImageView)
        bookCoverImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
