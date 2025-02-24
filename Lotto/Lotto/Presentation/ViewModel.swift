//
//  ViewModel.swift
//  Lotto
//
//  Created by 조성민 on 2/24/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class ViewModel {
    struct Input {
        let selectRound: PublishRelay<String>
        let observableTapped: ControlEvent<Void>
        let singleTapped: ControlEvent<Void>
    }
    
    struct Output {
        let roundText: Driver<String>
        let lottoData: Driver<Lotto>
        let ballColors: Driver<[BallColor]>
        let pickerItems: Driver<[Int]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let lottoData = PublishRelay<Lotto>()
        let initialRound = BehaviorRelay(value: "\(calculateLastSaturdayIteration())")
        
        input.observableTapped
            .withLatestFrom(input.selectRound)
            .compactMap { Int($0) }
            .withUnretained(self)
            .flatMapLatest { owner, round in
                return owner.fetchObservableLottoDate(round: round)
            }
            .bind(to: lottoData)
            .disposed(by: disposeBag)
        
        input.singleTapped
            .withLatestFrom(input.selectRound)
            .compactMap { Int($0) }
            .withUnretained(self)
            .flatMapLatest { owner, round in
                return owner.fetchSingleLottoDate(round: round)
            }
            .bind(to: lottoData)
            .disposed(by: disposeBag)
        
        let ballColors = lottoData
            .withUnretained(self)
            .map { owner, lotto in
                var colors: [BallColor] = []
                colors.append(owner.getBallColor(number: lotto.drwtNo1))
                colors.append(owner.getBallColor(number: lotto.drwtNo2))
                colors.append(owner.getBallColor(number: lotto.drwtNo3))
                colors.append(owner.getBallColor(number: lotto.drwtNo4))
                colors.append(owner.getBallColor(number: lotto.drwtNo5))
                colors.append(owner.getBallColor(number: lotto.drwtNo6))
                colors.append(owner.getBallColor(number: lotto.bnusNo))
                return colors
            }
            .asDriver(onErrorJustReturn: Array<BallColor>(repeating: .gray, count: 7))
        
        let pickerItems = initialRound
            .compactMap { Int($0) }
            .map { Array(Array(0...$0).reversed()) }
            .asDriver(onErrorJustReturn: [])
        
        initialRound
            .compactMap { Int($0) }
            .withUnretained(self)
            .flatMapLatest { owner, round in
                return owner.fetchObservableLottoDate(round: round)
            }
            .bind(to: lottoData)
            .disposed(by: disposeBag)
        
        let output = Output(
            roundText: initialRound.asDriver(),
            lottoData: lottoData.asDriver(onErrorJustReturn: .none),
            ballColors: ballColors,
            pickerItems: pickerItems
        )
        
        return output
    }
    
    private func calculateLastSaturdayIteration() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let firstRoundDate = dateFormatter.date(from: "2002-12-07") else {
            return 1
        }
        return Int(-firstRoundDate.timeIntervalSinceNow) / 7 / 60 / 60 / 24 + 1
    }
    
    private func fetchObservableLottoDate(round: Int) -> Observable<Lotto> {
        return Observable<Lotto>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
            AF.request(url, method: .get)
                .responseDecodable(of: Lotto.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    private func fetchSingleLottoDate(round: Int) -> Single<Lotto> {
        return Single<Lotto>.create { observer in
            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
            AF.request(url, method: .get)
                .responseDecodable(of: Lotto.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer(.success(value))
                    case .failure(let error):
                        observer(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
    
    private func getBallColor(number: Int) -> BallColor {
        switch number {
        case ...10:
            return .yellow
        case ...20:
            return .blue
        case ...30:
            return .red
        case ...40:
            return .gray
        default:
            return .green
        }
    }
}
