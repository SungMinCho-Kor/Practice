//
//  FolderViewController.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/5/25.
//

import UIKit
import RealmSwift

final class FolderViewController: UIViewController {
    
    let tableView = UITableView()
    var list: Results<Folder>!
    let repository: FolderRepository = FolderTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureConstraints()
        list = repository.fetchAll()
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureNavigation() {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "pencil"),
            style: .plain,
            target: self,
            action: #selector(backupTapped)
        )
        navigationItem.leftBarButtonItem = button
    }
    
    @objc private func backupTapped() {
        navigationController?.pushViewController(BackupViewController(), animated: true)
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
    }
    
   @objc func rightBarButtonItemClicked() {
       let vc = MainViewController()
       
       navigationController?.pushViewController(vc, animated: true)
   }
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        
        let data = list[indexPath.row]
        cell.titleLabel.text = data.name
        cell.subTitleLabel.text = "\(data.detail.count)개"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        let vc = FolderDetailViewController()
        vc.list = data.detail
        vc.id = data.id
        navigationController?.pushViewController(vc, animated: true)
//        repository.deleteItem(data: data)
//        repository.createMemo(data: data)
//        tableView.reloadData()
    }
}
