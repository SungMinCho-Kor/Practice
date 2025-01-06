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
        cityTitleLabel.font = .systemFont(
            ofSize: 20,
            weight: .bold
        )
    }
    
    private func keywordContainerViewDesign() {
        keywordContainerView.backgroundColor = .black.withAlphaComponent(0.7)
    }
    
    private func keywordLabelDesign() {
        keywordLabel.textColor = .white
        keywordLabel.font = .systemFont(ofSize: 14)
    }
    
    func configure(_ content: City) {
        thumbnailImageView.kf.setImage(with: URL(string: content.city_image))
        cityTitleLabel.text = "\(content.city_name) | \(content.city_english_name)"
        keywordLabel.text = " " + content.city_explain
    }
}
