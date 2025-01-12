//
//  TravelTalkGroupCollectionViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/13/25.
//

import UIKit

struct TravelTalkTwoCollectionViewCellContent {
    let firstProfileImage: String
    let secondProfileImage: String
    let chatroomName: String
    let lastChat: Chat
}

final class TravelTalkTwoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var firstProfileImageView: UIImageView!
    @IBOutlet private var secondProfileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var latestMessageLabel: UILabel!
    @IBOutlet private var latestMessageTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageViewDesign()
        nameLabelDesign()
        latestMessageLabelDesign()
        latestMessageTimeLabelDesign()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        firstProfileImageView.layer.cornerRadius = firstProfileImageView.frame.height / 2
        secondProfileImageView.layer.cornerRadius = secondProfileImageView.frame.height / 2
    }
}

//MARK: Design
extension TravelTalkTwoCollectionViewCell {
    private func profileImageViewDesign() {
        firstProfileImageView.layer.borderWidth = 0.5
        firstProfileImageView.layer.borderColor = UIColor.lightGray.cgColor
        secondProfileImageView.layer.borderWidth = 0.5
        secondProfileImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func nameLabelDesign() {
        nameLabel.font = .systemFont(
            ofSize: 18,
            weight: .semibold
        )
    }
    
    private func latestMessageLabelDesign() {
        latestMessageLabel.font = .systemFont(ofSize: 16)
        latestMessageLabel.textColor = .systemGray
    }
    
    private func latestMessageTimeLabelDesign() {
        latestMessageTimeLabel.font = .systemFont(ofSize: 14)
        latestMessageTimeLabel.textColor = .systemGray
    }
}

//MARK: Configure
extension TravelTalkTwoCollectionViewCell {
    func configure(_ content: TravelTalkTwoCollectionViewCellContent) {
        firstProfileImageView.image = UIImage(named: content.firstProfileImage)
        secondProfileImageView.image = UIImage(named: content.secondProfileImage)
        nameLabel.text = content.chatroomName
        latestMessageLabel.text = content.lastChat.message
        latestMessageTimeLabel.text = TravelTalkTwoCollectionViewCell.convertDateFormat(date: content.lastChat.date)
    }
}

//MARK: Type Property & Method
extension TravelTalkTwoCollectionViewCell {
    static let dateFormatter = DateFormatter()
    static func convertDateFormat(date: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let formattedDate = dateFormatter.date(from: date) else {
            print(#function, "wrong Date Format")
            return ""
        }
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: formattedDate)
    }
}
