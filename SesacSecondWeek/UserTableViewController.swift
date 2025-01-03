//
//  UserTableViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/3/25.
//

import UIKit
import Kingfisher

class UserTableViewController: UITableViewController {

    let friends: FriendsInfo = FriendsInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let row = friends.list[indexPath.row]
        
        cell.profileImageView.backgroundColor = .systemCyan
        cell.profileImageView.tintColor = .lightGray
        if let profileImageName = row.profile_image, let url = URL(string: profileImageName) {
            cell.profileImageView.kf.setImage(with: url)
        } else {
            cell.profileImageView.image = UIImage(systemName: "person.fill")
        }
        cell.profileImageView.layer.cornerRadius = 10
        cell.nameLabel.text = row.name
        cell.nameLabel.font = .boldSystemFont(ofSize: 20)
        cell.messageLabel.text = row.message
        cell.messageLabel.textColor = .darkGray
        cell.likeButton.setImage(UIImage(systemName: row.like ? "star.fill" : "star"), for: .normal)
        cell.likeButton.tintColor = .systemYellow
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
