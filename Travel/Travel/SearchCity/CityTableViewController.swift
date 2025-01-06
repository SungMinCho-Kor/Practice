//
//  CityTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/6/25.
//

import UIKit

class CityTableViewController: UITableViewController {
    
    private let cityInfo = CityInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            UINib(
                nibName: CityTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: CityTableViewCell.identifier
        )
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return cityInfo.city.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else {
            print("CityTableViewCell dequeueReusableCell 실패")
            return UITableViewCell()
        }
        cell.configure(cityInfo.city[indexPath.row])
        
        return cell
    }
    
}
