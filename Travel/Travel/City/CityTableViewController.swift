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
            cell.configure(row)
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
    
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if travelInfo.travel[indexPath.row].ad {
            return 100
        } else {
            return 180
        }
    }
    
}
