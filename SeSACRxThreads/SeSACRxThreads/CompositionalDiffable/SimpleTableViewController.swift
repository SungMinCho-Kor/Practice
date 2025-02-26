//
//  SimpleTableViewController.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/26/25.
//

import UIKit
import SnapKit

final class SimpleTableViewController: UIViewController {

    private lazy var tableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "simple")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SimpleTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "simple",
            for: indexPath
        )
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "\(indexPath.row)"
        configuration.image = UIImage(systemName: "star.fill")
        configuration.secondaryText = "ㅎㅇ"
        configuration.textProperties.color = .systemGreen
        configuration.secondaryTextProperties.color = .systemPink
        configuration.imageToTextPadding = 40
        
        cell.contentConfiguration = configuration
        return cell
    }
}
