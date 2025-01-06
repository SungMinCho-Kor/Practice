//
//  UserTableViewCell.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/3/25.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    
    // 스토리보드로 구현한 경우에만 실행
    // 코드 베이스에서는 같은 역할의 다른 메서드 존재
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
    }
    
    private func configure() {
        profileImageView.backgroundColor = .systemCyan
        profileImageView.tintColor = .lightGray
        profileImageView.layer.cornerRadius = 10
        nameLabel.font = .boldSystemFont(ofSize: 20)
        messageLabel.textColor = .darkGray
        likeButton.tintColor = .systemYellow
        messageLabel.numberOfLines = 0
    }
    
    func configure(row: Friends) {
        print(#function)
        if let profileImageName = row.profile_image, let url = URL(string: profileImageName) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(systemName: "person.fill")
        }
//        nameLabel.text = row.name
        nameLabel.text = row.nameDescription
        messageLabel.text = row.message
        likeButton.setImage(UIImage(systemName: row.like ? "star.fill" : "star"), for: .normal)
    }
}
