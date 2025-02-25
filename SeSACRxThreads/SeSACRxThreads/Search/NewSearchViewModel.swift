//
//  NewSearchViewModel.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/24/25.
//

import RxSwift
import RxCocoa

final class NewSearchViewModel {
    struct Input {
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let list: PublishSubject<[DailyBoxOfficeList]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let list = PublishSubject<[DailyBoxOfficeList]>()
        let output = Output(
            list: list
        )
        
        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .map { "\($0)" }
            .flatMap {
                NetworkManager.shared.callBoxOffice2(date: $0)
//                    .catch { error in
////                        switch error as? APIError {
////                        case .invalidURL:
////                        case .statusError:
////                        }
//                        return .just(Movie(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
//                    }
            }
            .subscribe(with: self) { owner, result in
                switch result {
                case .success(let movie):
                    list.onNext(movie.boxOfficeResult.dailyBoxOfficeList)
                case .failure(let error):
                    list.onNext([])
                }
            } onError: { owner, error in
                print(#function, "onError", error)
            } onCompleted: { owner in
                print(#function, "onCompleted")
            } onDisposed: { owner in
                print(#function, "onDisposed")
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
