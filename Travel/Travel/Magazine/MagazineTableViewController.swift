//
//  MagazineTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit
import Kingfisher

class MagazineTableViewController: UITableViewController {
    
    private let magazineInfo = MagazineInfo()
    
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MagazineTableViewCell.identifier,
            for: indexPath
        ) as? MagazineTableViewCell else {
            print("MagazineTableViewCell dequeueReusableCell 실패")
            return UITableViewCell()
        }
        cell.configure(row)
        
        return cell
    }
}
