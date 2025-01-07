//
//  UserTableViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/3/25.
//

import UIKit
import Kingfisher

class UserTableViewController: UITableViewController {

    var friends: FriendsInfo = FriendsInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(rightBarButtonItemTapped)
        )
        
//        let nib = UINib(
//            nibName: "NoProfileTableViewCell",
//            bundle: nil
//        )
//        tableView.register(
//            nib,
//            forCellReuseIdentifier: "NoProfileTableViewCell"
//        )
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return friends.list.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: "NoProfileTableViewCell",
//            for: indexPath
//        ) as? NoProfileTableViewCell else {
//            return UITableViewCell()
//        }
        
        // UserTableViewCell 인스턴스 생성
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserTableViewCell.identifier,
            for: indexPath
        ) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let row = friends.list[indexPath.row]
        cell.configure(row: row)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(
            self,
            action: #selector(likeButtonTapped),
            for: .touchUpInside
        )
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let sb = UIStoryboard(name: "User", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "BrownViewController") as! BrownViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        friends.list[sender.tag].like.toggle()
        tableView.reloadRows(
            at: [IndexPath(
                row: sender.tag,
                section: 0
            )],
            with: .fade
        )
    }

    @objc private func rightBarButtonItemTapped(_ sender: UIBarButtonItem) {
//        let sb = UIStoryboard(name: "User", bundle: nil)
//        
//        let vc = sb.instantiateViewController(withIdentifier: "GrayViewController") as! GrayViewController
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GrayViewController") as! GrayViewController
        
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        
//        vc.titleLabel.text = "하하"
        // 값 전달시 outlet은 활용 불가능
        vc.contents = "하하"
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
//        navigationController?.pushViewController(vc, animated: true)
    }
}
