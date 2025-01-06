//
//  CityTableViewswift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starImageViewList: [UIImageView]!
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(
            ofSize: 16,
            weight: .black
        )
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 14)
        informationLabel.font = .systemFont(ofSize: 12)
        informationLabel.textColor = .lightGray
        informationLabel.numberOfLines = 0
        thumbnailImageView.contentMode = .scaleToFill
        thumbnailImageView.layer.cornerRadius = 10
        likeButton.tintColor = .systemPink
        for idx in 0..<5 {
            starImageViewList[idx].image = UIImage(systemName: "star.fill")
            starImageViewList[idx].tintColor = .systemGray5
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        for idx in 0..<5 {
            starImageViewList[idx].tintColor = .systemGray5
        }
        informationLabel.text = ""
        thumbnailImageView.image = UIImage(systemName: "photo")
        likeButton.setImage(
            UIImage(systemName: "heart"),
            for: .normal
        )
    }
    
    func configure(_ content: Travel) {
        titleLabel.text = content.title
        descriptionLabel.text = content.description
        let grade = Int(content.grade ?? 0)
        for idx in 0..<5 {
            starImageViewList[idx].tintColor = grade > idx ? .systemYellow : .systemGray5
        }
        informationLabel.text = "(\((content.rateCount ?? 0).changeToDecimalFormat())) · 저장 \((content.save ?? 0).changeToDecimalFormat())"
        if let imageURLString = content.travel_image {
            thumbnailImageView.kf.setImage(with: URL(string: imageURLString))
        } else {
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
        likeButton.setImage(
            UIImage(systemName: content.like ?? false ? "heart.fill" : "heart"),
            for: .normal
        )
    }
}
