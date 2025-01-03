//
//  UserTableViewCell.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/3/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    func configure(profileImage: UIImage, name: String, message: String?) {
        profileImageView.image = profileImage
        nameLabel.text = name
        messageLabel.text = message
    }
    
}
