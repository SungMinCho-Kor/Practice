//
//  NewSearchViewController.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/24/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class NewSearchViewController: UIViewController {
    private let tableView: UITableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
        return view
    }()
    
    private let searchBar = UISearchBar()
    
    private let disposeBag = DisposeBag()
    private let viewModel = NewSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
        
//        NetworkManager.shared.callBoxOffice(date: "20250201")
//            .subscribe(with: self) { owner, movie in
//                dump(movie)
//            } onError: { owner, error in
//                print(#function, "onError", error)
//            } onCompleted: { owner in
//                print(#function, "onCompleted")
//            } onDisposed: { owner in
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
    }
    
    func bind() {
        // [map]
//        tableView.rx.itemSelected
//            .map { _ in
//                Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//            }
//            .subscribe(with: self) { owner, value in
//                value.subscribe { number in
//                    print(number)
//                }
//                .disposed(by: owner.disposeBag)
//            }
//            .disposed(by: disposeBag)
        
        
        // [withLatestFrom]
//        tableView.rx.itemSelected
//            .withLatestFrom(
//                Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//            )
//            .subscribe(with: self) { owner, value in
//                print(value)
//            }
//            .disposed(by: disposeBag)
        
        // [flatMap]
//        tableView.rx.itemSelected
//            .flatMap { _ in
//                Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//                    .debug()
//            }
//            .subscribe(with: self) { owner, value in
//                print(value)
//            } onDisposed: { owner in
//                print("dispose")
//            }
//            .disposed(by: disposeBag)
        
        // [flatMapLatest]
        tableView.rx.itemSelected
            .flatMapLatest { _ in
                Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
                    .debug()
            }
            .subscribe(with: self) { owner, value in
                print(value)
            } onDisposed: { owner in
                print("dispose")
            }
            .disposed(by: disposeBag)
        
        
        
        let input = NewSearchViewModel.Input(
            searchTap: searchBar.rx.searchButtonClicked,
            searchText: searchBar.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.list
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: SearchTableViewCell.identifier,
                    cellType: SearchTableViewCell.self
                )
            ) { row, element, cell in
                cell.appNameLabel.text = element.movieNm
            }
            .disposed(by: disposeBag)
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.rowHeight = 80
    }
}
