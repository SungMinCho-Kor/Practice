//
//  MarketViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import SnapKit

class MarketViewController: UIViewController {
 
    let tableView = UITableView()
    
    let list = Array(1...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()

    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.id)
    }
    
    func configureView() {
        view.backgroundColor = .white
    }

}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function, list.count)
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.id, for: indexPath) as? MarketTableViewCell else { return UITableViewCell() }
        
        let data = list[indexPath.row]
        
        cell.nameLabel.text = "마켓 레이블: \(data)"
        
        return cell
    }
    
}
