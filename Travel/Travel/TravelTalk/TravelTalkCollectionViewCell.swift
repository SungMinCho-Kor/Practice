//
//  TravelTalkCollectionViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/10/25.
//

import UIKit

final class TravelTalkCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var latestMessageLabel: UILabel!
    @IBOutlet private var latestMessageTimeLabel: UILabel!
    @IBOutlet private var verticalStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageViewDesign()
        nameLabelDesign()
        latestMessageLabelDesign()
        latestMessageTimeLabelDesign()
        verticalStackViewDesign()
    }
}

//MARK: Design
extension TravelTalkCollectionViewCell {
    private func profileImageViewDesign() {
        profileImageView.layer.cornerRadius = 10
    }
    
    private func nameLabelDesign() {
        nameLabel.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
    }
    
    private func latestMessageLabelDesign() {
        latestMessageLabel.font = .systemFont(ofSize: 18)
        latestMessageLabel.textColor = .systemGray6
    }
    
    private func latestMessageTimeLabelDesign() {
        latestMessageTimeLabel.font = .systemFont(ofSize: 14)
        latestMessageTimeLabel.textColor = .systemGray4
    }
    
    private func verticalStackViewDesign() {
        verticalStackView.spacing = 12
    }
}

//MARK: Configure
extension TravelTalkCollectionViewCell {
    func configure() {
        
    }
}
