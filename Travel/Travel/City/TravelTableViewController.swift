//
//  TravelTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

final class TravelTableViewController: UITableViewController {
    
    private var travelInfo = TravelInfo()
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return travelInfo.travel.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let row = travelInfo.travel[indexPath.row]
        if !row.ad, let cell = tableView.dequeueReusableCell(
            withIdentifier: TravelTableViewCell.identifier,
            for: indexPath
        ) as? TravelTableViewCell {
            cell.configure(row)
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(
                self,
                action: #selector(likeButtonTapped),
                for: .touchUpInside
            )
            
            return cell
        } else if row.ad, let cell = tableView.dequeueReusableCell(
            withIdentifier: AdTableViewCell.identifier,
            for: indexPath
        ) as? AdTableViewCell {
            cell.configure(row, row: indexPath.row)
            
            return cell
        } else {
            print("Cell 오류", #function)
            return UITableViewCell()
        }
    }
    
    @objc private func likeButtonTapped(_ sender: UIButton) {
        travelInfo.travel[sender.tag].like?.toggle()
        tableView.reloadRows(
            at: [IndexPath(
                row: sender.tag,
                section: 0
            )],
            with: .automatic
        )
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
