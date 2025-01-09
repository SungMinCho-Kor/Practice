//
//  SampleCollectionViewCell.swift
//  ThirdWeek
//
//  Created by 조성민 on 1/9/25.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: SampleCollectionViewCell.self)
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }

}
