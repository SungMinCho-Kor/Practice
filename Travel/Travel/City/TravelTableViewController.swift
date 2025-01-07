//
//  TravelTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

final class TravelTableViewController: UITableViewController {
    
    private var travelInfo = TravelInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDesign()
    }
    
    // 해당 함수가 TravelDetailViewController에 있는 것이 아니라
    // TravelTableViewController에 있어야 적용이 되는 이유가 궁금합니다!
    private func navigationDesign() {
        let backButton = UIBarButtonItem(
            title: nil,
            style: .plain,
            target: self,
            action: nil
        )
        backButton.tintColor = .black
        navigationItem.backBarButtonItem = backButton
    }
    
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
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if travelInfo.travel[indexPath.row].ad {
            
        } else {
            guard let detailViewController = self.storyboard?.instantiateViewController(identifier: "TravelDetailViewController") as? TravelDetailViewController else {
                print("TravelDetailViewController wrong Identifier")
                return
            }
            detailViewController.travel = travelInfo.travel[indexPath.row]
            navigationController?.pushViewController(
                detailViewController,
                animated: true
            )
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
