//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 8/1/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
   
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    lazy var items = BehaviorSubject(value: data)

    var data = [
        "First Item",
        "Second Item",
        "Third Item",
        "Fourth Item",
        "Fifth Item",
        "Sixth Item",
        "Seventh Item",
        "Eighth Item",
        "Ninth Item",
        "Tenth Item",
        "Eleventh Item",
        "Twelfth Item",
        "Thirteenth Item",
        "Fourteenth Item",
        "Fifteenth Item"
    ]
    
    let searchBar = UISearchBar()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
    }
    
    func bind() {
        items
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: SearchTableViewCell.identifier,
                    cellType: SearchTableViewCell.self
                )
            ) { row, element, cell in
                cell.appNameLabel.text = element
                cell.downloadButton.rx.tap
                    .bind(with: self) { owner, _ in
                        print("다운로드")
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .rowHeight
            .onNext(180)
        
        searchBar
            .rx
            .searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty, resultSelector: { _, text in
                return "\(text) 추가됨"
            })
            .bind(with: self) { owner, text in
                owner.data.insert(text, at: 0)
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)
        
        searchBar
            .rx
            .text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler())
            .distinctUntilChanged()
            .withUnretained(self)
            .map { owner, text in
                owner.data.filter { $0.contains(text) }
            }
            .bind(with: self) { owner, data in
                owner.items.onNext(data.isEmpty ? owner.data : data)
            }
            .disposed(by: disposeBag)
    }
     
    private func setSearchController() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(plusButtonClicked))
    }
    
    @objc func plusButtonClicked() {
        print("추가 버튼 클릭")
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
