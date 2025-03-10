//
//  MultiSectionViewController.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

// Section
struct Mentor {
    let name: String // 섹션 타이틀
    var items: [Item] // 섹션 내 셀에 들어갈 정보
}

extension Mentor: SectionModelType {
    typealias Item = Ment
    
    init(original: Mentor, items: [Item]) {
        self = original
        self.items = items
    }
}

struct Ment {
    let word: String
    let count = Int.random(in: 0...20)
}


final class MultiSectionViewController: UIViewController {
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        let mentor = [
            Mentor(
                name: "Jack",
                items: [
                    Ment(word: "맛점하셨나요?"),
                    Ment(word: "다시해볼까요?"),
                    Ment(word: "가보겠습니다"),
                    Ment(word: "자 과제 나갑니다"),
                    Ment(word: "진짠데"),
                    Ment(word: "돌아오세요"),
                    Ment(word: "저는 여러분이 고생했으면 좋겠어요")
                ]
            ),
            Mentor(
                name: "Den",
                items: [
                    Ment(word: "정답은 없죠"),
                    Ment(word: "그건 ~님이 찾아보고 알려주세요"),
                    Ment(word: "스스로 해보시고"),
                    Ment(word: "로그 찍어보세요"),
                    Ment(word: "화이팅")
                ]
            ),
            Mentor(
                name: "Bran",
                items: [
                    Ment(word: "잘 되시나요")
                ]
            )
        ]
        
        // 1 - TableViewSectionedDataSource<SectionModelType>
        // 4 - Section
//        let dataSource = RxTableViewSectionedReloadDataSource<Mentor> { dataSource, tableView, indexPath, item in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
//            cell.textLabel?.text = "\(item.word) - \(item.count)번"
//            
//            return cell
//        }
        let dataSource = RxTableViewSectionedReloadDataSource<Mentor> { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
            cell.textLabel?.text = "\(item.word) - \(item.count)번"
            
            return cell
        }
        
        
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].name
        }
        
        Observable.just(mentor)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
