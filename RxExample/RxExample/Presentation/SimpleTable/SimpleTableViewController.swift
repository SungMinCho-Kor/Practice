//
//  SimpleTableViewController.swift
//  RxExample
//
//  Created by 조성민 on 2/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SimpleTableViewController: UIViewController, UITableViewDelegate {
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        bind()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "Cell"
        )
    }

    private func bind() {
        let items = Observable.just(
            (0..<40).map { $0.description }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .bind(with: self) { owner, value in
                owner.presentAlert("Tapped `\(value)`")
            }
            .disposed(by: disposeBag)

        tableView.rx
            .itemAccessoryButtonTapped
            .bind(with: self) { owner, indexPath in
                owner.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            }
            .disposed(by: disposeBag)
    }
    
    private func presentAlert(_ message: String) {
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: "확인",
            style: .default
        )
        alertController.addAction(ok)
        present(alertController, animated: true)
    }
}
