//
//  TenViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

class TenViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDesign()
    }
    
    private func tableViewDesign() {
        let xib = UINib(nibName: "NoProfileTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "NoProfileTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoProfileTableViewCell", for: indexPath) as? NoProfileTableViewCell else {
            print("wrong identifier")
            return UITableViewCell()
        }
        
        return cell
    }
    
}
