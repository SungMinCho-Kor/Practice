//
//  CityTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    var travelInfo = TravelInfo() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.travel.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let row = travelInfo.travel[indexPath.row]
        if !row.ad, let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as? CityTableViewCell {
            cell.titleLabel.text = row.title
            cell.titleLabel.numberOfLines = 0
            cell.titleLabel.font = .systemFont(ofSize: 16, weight: .black)
            
            cell.descriptionLabel.text = row.description
            cell.descriptionLabel.textColor = .darkGray
            cell.descriptionLabel.numberOfLines = 0
            cell.descriptionLabel.font = .systemFont(ofSize: 14)
            
            let grade = Int(row.grade ?? 0)
            for idx in 0..<5 {
                cell.starImageViewList[idx].image = UIImage(systemName: "star.fill")
                cell.starImageViewList[idx].tintColor = grade > idx ? .systemYellow : .systemGray5
            }
            
            cell.informationLabel.text = "(\((row.rateCount ?? 0).changeToDecimalFormat())) · 저장 \((row.save ?? 0).changeToDecimalFormat())"
            cell.informationLabel.font = .systemFont(ofSize: 12)
            cell.informationLabel.textColor = .lightGray
            cell.informationLabel.numberOfLines = 0
            
            cell.thumbnailImageView.contentMode = .scaleToFill
            cell.thumbnailImageView.layer.cornerRadius = 10
            if let imageURLString = row.travel_image {
                cell.thumbnailImageView.kf.setImage(with: URL(string: imageURLString))
            } else {
                cell.thumbnailImageView.image = UIImage(systemName: "photo")
            }
            
            cell.likeButton.setImage(UIImage(systemName: row.like ?? false ? "heart.fill" : "heart"), for: .normal)
            cell.likeButton.tintColor = .systemPink
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return cell
        } else if row.ad, let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as? AdTableViewCell {
            cell.adLabel.text = " AD "
            cell.adLabel.font = .boldSystemFont(ofSize: 8)
            cell.adLabel.layer.cornerRadius = 4
            cell.adLabel.clipsToBounds = true
            cell.adLabel.backgroundColor = .white
            
            let colors: [UIColor] = [.systemRed, .systemBlue, .systemPink, .systemPurple, .systemGreen, .systemCyan]
            cell.backgroundColorView.backgroundColor = colors[indexPath.row % colors.count]
            cell.backgroundColorView.layer.cornerRadius = 10
            
            cell.contentLabel.text = row.title
            cell.contentLabel.numberOfLines = 0
            cell.contentLabel.textAlignment = .center
            cell.contentLabel.font = .systemFont(ofSize: 16, weight: .black)
            
            return cell
        } else {
            print("Cell 오류", #function)
            return UITableViewCell()
        }
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travelInfo.travel[indexPath.row].ad {
            return 100
        } else {
            return 180
        }
    }
    
}
