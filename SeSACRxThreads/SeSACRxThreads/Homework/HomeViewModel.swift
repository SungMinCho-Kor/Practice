//
//  HomeViewModel.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/20/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeViewModel {
    struct Input {
        let searchButtonTapped: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let recentText: PublishSubject<String>
    }
    
    struct Output {
        let recent: BehaviorRelay<[String]>
        let items: BehaviorSubject<[String]>
    }
    
    private let disposeBag = DisposeBag()
    private var items = ["Test"]
    private var recent: [String] = []
    
    func transform(input: Input) -> Output {
        let itemList = BehaviorSubject(value: items)
        let recentList = BehaviorRelay(value: recent)
        
        input.searchButtonTapped
            .withLatestFrom(input.searchText)
            .map { "\($0)님" }
            .asDriver(onErrorJustReturn: "손님")
            .drive(with: self) { owner, value in
                owner.items.append(value)
                itemList.onNext(owner.items)
            }
            .disposed(by: disposeBag)
        
        input.recentText
            .subscribe(with: self) { owner, text in
                owner.recent.insert(text, at: 0)
                recentList.accept(owner.recent)
            }
            .disposed(by: disposeBag)
        
        return Output(
            recent: recentList,
            items: itemList
        )
    }
}
