//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

final class HomeworkViewController: UIViewController {
    private let viewModel = HomeworkViewModel()
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private let searchBar = UISearchBar()
     
    deinit {
        print(#function, self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
     
    private func bind() {
        let cellSelected = tableView.rx.itemSelected
        let output = viewModel.transform(
            input: HomeworkViewModel.Input(
                cellSelected: cellSelected
            )
        )
        
        output.users
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: PersonTableViewCell.identifier,
                    cellType: PersonTableViewCell.self
                )
            ) { [weak self] row, element, cell in
                guard let self else {
                    print(#function, "No Self")
                    return
                }
                cell.usernameLabel.text = element.name
                cell.profileImageView.kf.setImage(with: URL(string: element.profileImage))
                cell.detailButton.rx.tap
                    .bind(with: self) { owner, _ in
                        owner.navigationController?.pushViewController(DetailViewController(), animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        output.selectedUsers
            .bind(
                to: collectionView.rx.items(
                    cellIdentifier: UserCollectionViewCell.identifier,
                    cellType: UserCollectionViewCell.self
                )
            ) { row, element, cell in
                cell.label.text = element.name
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
