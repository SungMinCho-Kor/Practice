//
//  CityTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/6/25.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet var thumbnailDimView: UIView!
    @IBOutlet private var cityTitleLabel: UILabel!
    @IBOutlet var keywordContainerView: UIView!
    @IBOutlet private var keywordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
        thumbnailImageViewDesign()
        thumbnailDimViewDesign()
        cityTitleLabelDesign()
        keywordContainerViewDesign()
        keywordLabelDesign()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        cityTitleLabel.text = ""
        keywordLabel.text = ""
    }
    
    private func cellDesign() {
        selectionStyle = .none
        contentView.clipsToBounds = true
    }
    
    private func thumbnailImageViewDesign() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMaxYCorner
        ]
        thumbnailImageView.layer.cornerRadius = 20
    }
    
    private func thumbnailDimViewDesign() {
        thumbnailDimView.backgroundColor = .black.withAlphaComponent(0.2)
        thumbnailDimView.clipsToBounds = true
        thumbnailDimView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMaxYCorner
        ]
        thumbnailDimView.layer.cornerRadius = 20
    }
    
    private func cityTitleLabelDesign() {
        cityTitleLabel.textColor = .white
    }
    
    private func keywordContainerViewDesign() {
        keywordContainerView.backgroundColor = .black.withAlphaComponent(0.7)
    }
    
    private func keywordLabelDesign() {
        keywordLabel.textColor = .white
    }
    
    func configure(_ content: City, highlightString: String? = nil) {
        thumbnailImageView.kf.setImage(with: URL(string: content.city_image))
        let highlightText = highlightString?.replacingOccurrences(
            of: " ",
            with: ""
        ) ?? ""
        let cityTitle = "\(content.city_name) | \(content.city_english_name)"
        let cityTitleAttributedText: NSMutableAttributedString = NSMutableAttributedString(
            string: cityTitle,
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 20,
                weight: .bold
            )]
        )
        let cityRange = (cityTitle as NSString).range(
            of: highlightText,
            options: .caseInsensitive
        )
        cityTitleAttributedText.addAttribute(
            .foregroundColor,
            value: UIColor.yellow,
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
            value: UIColor.yellow,
            range: keywordRange
        )
        keywordLabel.attributedText = keywordTitleAttributedText
    }
}
