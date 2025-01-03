//
//  MagazineTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {
    
    let magazineInfo = MagazineInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 420
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return magazineInfo.magazine.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let row = magazineInfo.magazine[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineTableViewCell", for: indexPath) as! MagazineTableViewCell
        cell.titleLabel.text = row.title
        cell.subtitleLabel.text = row.subtitle
        cell.thumbnailImageView.kf.setImage(with: URL(string: row.photo_image))
        cell.dateLabel.text = convertDateFormat(date: row.date)
    
        cell.thumbnailImageView.contentMode = .scaleAspectFill
        cell.thumbnailImageView.layer.cornerRadius = 10
        cell.titleLabel.font = .systemFont(ofSize: 28, weight: .black)
        cell.titleLabel.numberOfLines = 2
        cell.subtitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        cell.subtitleLabel.textColor = .lightGray
        cell.dateLabel.font = .systemFont(ofSize: 12)
        cell.dateLabel.textColor = .lightGray
        
        return cell
    }
    
    func convertDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        guard let date = dateFormatter.date(from: date) else {
            print("잘못된 date 형식")
            return ""
        }
        dateFormatter.dateFormat = "yy년 M월 d일"
        return dateFormatter.string(from: date)
    }
    
}
