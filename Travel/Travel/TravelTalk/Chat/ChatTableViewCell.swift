//
//  ChatTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/12/25.
//

import UIKit

final class ChatTableViewCell: UITableViewCell {
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var messageContainerView: UIView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
        profileImageViewDesign()
        nameLabelDesign()
        messageContainerViewDesign()
        messageLabelDesign()
        timeLabelDesign()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
}

//MARK: Design
extension ChatTableViewCell {
    private func cellDesign() {
        selectionStyle = .none
    }
    
    private func profileImageViewDesign() {
        profileImageView.layer.borderWidth = 0.5
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func nameLabelDesign() {
        nameLabel.font = .systemFont(
            ofSize: 16,
            weight: .bold
        )
    }
    
    private func messageContainerViewDesign() {
        messageContainerView.layer.cornerRadius = 10
        messageContainerView.layer.borderWidth = 0.5
        messageContainerView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func messageLabelDesign() {
        messageLabel.font = .systemFont(
            ofSize: 14,
            weight: .semibold
        )
        messageLabel.numberOfLines = 0
    }
    
    private func timeLabelDesign() {
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .darkGray
    }
}

//MARK: Configure
extension ChatTableViewCell {
    func configure(_ content: Chat) {
        profileImageView.image = UIImage(named: content.user.profileImage)
        nameLabel.text = content.user.rawValue
        timeLabel.text = ChatTableViewCell.convertDateFormat(date: content.date)
        messageLabel.text = content.message
    }
}

//MARK: Type Property & Method
extension ChatTableViewCell {
    static let dateFormatter = DateFormatter()
    static func convertDateFormat(date: String) -> String {
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let formattedDate = dateFormatter.date(from: date) else {
            print(#function, "wrong Date Format")
            return ""
        }
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: formattedDate)
    }
}
