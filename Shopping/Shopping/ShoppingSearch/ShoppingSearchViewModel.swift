//
//  ShoppingSearchViewModel.swift
//  Shopping
//
//  Created by 조성민 on 2/25/25.
//

import RxSwift
import RxCocoa

final class ShoppingSearchViewModel: ViewModel {
    struct Input {
        let searchText: ControlProperty<String>
        let searchTapped: ControlEvent<Void>
    }
    
    struct Output {
        let presentAlert: Driver<Void>
        let pushDetailViewController: Driver<String>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let presentAlert = PublishRelay<Void>()
        let pushDetailViewController = PublishRelay<String>()
        let output = Output(
            presentAlert: presentAlert.asDriver(onErrorJustReturn: ()),
            pushDetailViewController: pushDetailViewController.asDriver(onErrorJustReturn: "")
        )
        
        input.searchTapped
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .bind { searchText in
                if searchText.count >= 2 {
                    pushDetailViewController.accept(searchText)
                } else {
                    presentAlert.accept(())
                }
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
