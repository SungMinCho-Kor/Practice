//
//  FolderViewController.swift
//  Shopping
//
//  Created by 조성민 on 3/5/25.
//

import UIKit
import SnapKit
import RealmSwift

final class FolderViewController: BaseViewController {
    private let folderTableView = UITableView()
    
    private let repository: FolderRepository = FolderTableRepository()
    private var list: Results<Folder>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        folderTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = repository.fetchAll()
    }
    
    override func configureNavigation() {
        navigationItem.title = "위시리스트 폴더"
        
        let backButton = UIBarButtonItem(
            image: nil,
            style: .plain,
            target: nil,
            action: nil
        )
        backButton.tintColor = .white
        navigationItem.backBarButtonItem = backButton
    }
    
    override func configureHierarchy() {
        view.addSubview(folderTableView)
    }
    
    override func configureLayout() {
        folderTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureViews() {
        folderTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "folder"
        )
        folderTableView.delegate = self
        folderTableView.dataSource = self
    }
}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return list.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "folder",
            for: indexPath
        )
        let item = list[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.image = UIImage(systemName: "folder.fill")
        configuration.text = item.name
        configuration.secondaryText = "\(item.detail.count)개의 위시"
        cell.contentConfiguration = configuration
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        navigationController?.pushViewController(
            WishListViewController(folder: list[indexPath.row]),
            animated: true
        )
    }
}
