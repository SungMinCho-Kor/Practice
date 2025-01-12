//
//  UserChatTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/12/25.
//

import UIKit

final class UserChatTableViewCell: UITableViewCell {
    @IBOutlet private var messageContainerView: UIView!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
        messageContainerViewDesign()
        messageLabelDesign()
        timeLabelDesign()
    }
}

//MARK: Design
extension UserChatTableViewCell {
    private func cellDesign() {
        selectionStyle = .none
    }
    
    private func messageContainerViewDesign() {
        messageContainerView.layer.cornerRadius = 10
        messageContainerView.layer.borderWidth = 0.5
        messageContainerView.layer.borderColor = UIColor.black.cgColor
        messageContainerView.backgroundColor = .lightGray
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
extension UserChatTableViewCell {
    func configure(_ content: Chat) {
        messageLabel.text = content.message
        timeLabel.text = convertDateFormat(date: content.date)
    }
    
    private func convertDateFormat(date: String) -> String {
        let dateFormatter = Chat.dateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let formattedDate = dateFormatter.date(from: date) else {
            print(#function, "wrong Date Format")
            return ""
        }
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: formattedDate)
    }
}
