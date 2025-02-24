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

//final class ViewModel {
//    struct Input {
//        let selectRound: Observable<Int>
//    }
//    
//    struct Output {
//        let maxRound: Driver<[Int]>
//        let fetchData: Observable<Lotto>
//        let ballCollor: Driver<[BallColor]>
//    }
//    
//    private let disposeBag = DisposeBag()
//    
//    func transform(input: Input) -> Output {
//        let maxRoundNum = calculateLastSaturdayIteration()
//        let maxRound = BehaviorRelay(value: Array(Array(0...maxRoundNum).reversed()))
//        
//        let fetchData = input.selectRound
//            .withUnretained(self)
//            .flatMapLatest { owner, round in
//                return owner.fetchLottoDate(round: round)
//            }
//        
//        let ballColor = fetchData
//            .withUnretained(self)
//            .map { owner, lotto in
//                var colors:[BallColor] = []
//                colors.append(owner.getBallColor(number: lotto.drwtNo1))
//                colors.append(owner.getBallColor(number: lotto.drwtNo2))
//                colors.append(owner.getBallColor(number: lotto.drwtNo3))
//                colors.append(owner.getBallColor(number: lotto.drwtNo4))
//                colors.append(owner.getBallColor(number: lotto.drwtNo5))
//                colors.append(owner.getBallColor(number: lotto.drwtNo6))
//                colors.append(owner.getBallColor(number: lotto.bnusNo))
//                return colors
//            }
//        
//        let output = Output(
//            maxRound: maxRound.asDriver(),
//            fetchData: fetchData,
//            ballCollor: ballColor.asDriver(onErrorJustReturn: Array<BallColor>(repeating: .gray, count: 7))
//        )
//        
//        return output
//    }
//    
//    private func calculateLastSaturdayIteration() -> Int {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        guard let firstRoundDate = dateFormatter.date(from: "2002-12-07") else {
//            return 1
//        }
//        return Int(-firstRoundDate.timeIntervalSinceNow) / 7 / 60 / 60 / 24 + 1
//    }
//    
//    private func fetchLottoDate(round: Int) -> Observable<Lotto> {
//        return Observable<Lotto>.create { observer in
//            let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
//            AF.request(url, method: .get)
//                .responseDecodable(of: Lotto.self) { response in
//                    switch response.result {
//                    case .success(let value):
//                        observer.onNext(value)
//                        observer.onCompleted()
//                    case .failure(let error):
//                        observer.onError(error)
//                    }
//                }
//            return Disposables.create()
//        }
//    }
//    
//    private func getBallColor(number: Int) -> BallColor {
//        switch number {
//        case ...10:
//            return .yellow
//        case ...20:
//            return .blue
//        case ...30:
//            return .red
//        case ...40:
//            return .gray
//        default:
//            return .green
//        }
//    }
//
//}



final class ViewModel {
    struct Input {
        let selectRound: Observable<Int>
    }
    
    struct Output {
        let roundText: Driver<String>
        let lottoData: Driver<Lotto>
        let ballColors: Driver<[BallColor]>
        let pickerItems: Driver<[Int]>
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let roundText = BehaviorRelay(value: calculateLastSaturdayIteration())
        let lottoData = roundText
            .withUnretained(self)
            .flatMapLatest { owner, round in
                owner.fetchLottoDate(round: round)
            }
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
        let pickerItems = roundText
            .map { Array(Array(0...$0).reversed()) }
            .asDriver(onErrorJustReturn: [])
            
        
        let output = Output(
            roundText: roundText.map { "\($0)" }.asDriver(onErrorJustReturn: ""),
            lottoData: lottoData.asDriver(onErrorJustReturn: .none),
            ballColors: ballColors,
            pickerItems: pickerItems
        )
        
        input.selectRound
            .bind(to: roundText)
            .disposed(by: disposeBag)
        
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
    
    private func fetchLottoDate(round: Int) -> Observable<Lotto> {
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
