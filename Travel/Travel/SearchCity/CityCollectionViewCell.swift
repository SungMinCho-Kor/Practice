//
//  CityCollectionViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

final class CityCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var cityTitleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageViewDesign()
        cityTitleLabelDesign()
        descriptionLabelDesign()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        cityTitleLabel.text = ""
        descriptionLabel.text = ""
    }
    
    private func thumbnailImageViewDesign() {
        thumbnailImageView.layer.cornerRadius = bounds.width / 2.0
        thumbnailImageView.contentMode = .scaleAspectFill
    }
    
    private func cityTitleLabelDesign() {
        cityTitleLabel.textAlignment = .center
        cityTitleLabel.numberOfLines = 0
    }
    
    private func descriptionLabelDesign() {
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
    }
    
    func configure(
        _ content: City,
        highlightString: String? = nil
    ) {
        thumbnailImageView.kf.setImage(with: URL(string: content.city_image))
        let highlightText = highlightString?.replacingOccurrences(
            of: " ",
            with: ""
        ) ?? ""
        let cityTitle = "\(content.city_name) | \(content.city_english_name)"
        let cityTitleAttributedText: NSMutableAttributedString = NSMutableAttributedString(
            string: cityTitle,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 16,
                weight: .bold
            )]
        )
        let cityRange = (cityTitle as NSString).range(
            of: highlightText,
            options: .caseInsensitive
        )
        cityTitleAttributedText.addAttribute(
            .foregroundColor,
            value: UIColor.systemPink,
            range: cityRange
        )
        cityTitleLabel.attributedText = cityTitleAttributedText
        
        let keywordTitleAttributedText: NSMutableAttributedString = NSMutableAttributedString(
            string: content.city_explain,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        )
        let keywordRange = (content.city_explain as NSString).range(
            of: highlightText,
            options: .caseInsensitive
        )
        keywordTitleAttributedText.addAttribute(
            .foregroundColor,
            value: UIColor.systemPink,
            range: keywordRange
        )
        descriptionLabel.attributedText = keywordTitleAttributedText
    }
}
