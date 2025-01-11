//
//  TravelTalkCollectionViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/10/25.
//

import UIKit

struct TravelTalkCollectionViewCellContent {
    let chatroomImage: String
    let chatroomName: String
    let lastChat: Chat
}

final class TravelTalkCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var profileImageView: UIImageView!
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
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
}

//MARK: Design
extension TravelTalkCollectionViewCell {
    private func profileImageViewDesign() {
        profileImageView.layer.borderWidth = 0.5
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
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
extension TravelTalkCollectionViewCell {
    func configure(_ content: TravelTalkCollectionViewCellContent) {
        profileImageView.image = UIImage(named: content.chatroomImage) 
        nameLabel.text = content.chatroomName
        latestMessageLabel.text = content.lastChat.message
        latestMessageTimeLabel.text = TravelTalkCollectionViewCell.convertDateFormat(date: content.lastChat.date)
    }
}

//MARK: Type Property & Method
extension TravelTalkCollectionViewCell {
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
