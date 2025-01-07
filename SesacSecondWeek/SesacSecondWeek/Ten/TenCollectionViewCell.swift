//
//  TenCollectionViewCell.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

class TenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var postImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        postImageView.backgroundColor = .systemRed
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
}
