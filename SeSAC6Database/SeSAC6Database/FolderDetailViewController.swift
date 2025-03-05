//
//  FolderDetailViewController.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/5/25.
//

import UIKit
import RealmSwift

class FolderDetailViewController: UIViewController {
    
    let tableView = UITableView()
    
    private let repository: UserRepository = UserTableRepository()
    
    var list: List<UserTable>!
    var id: ObjectId!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        repository.getFileURL()
        configureHierarchy()
        configureView()
        configureConstraints()
        
        repository.getFileURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print(#function)
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
          
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        vc.id = id
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FolderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.name
        cell.subTitleLabel.text = data.category
        cell.overviewLabel.text = "\(data.money)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        repository.updateItem(data: data)
        tableView.reloadData()
    }
}
