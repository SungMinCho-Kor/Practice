//
//  BirthdayViewModel.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/19/25.
//

import Foundation
import RxSwift
import RxCocoa

final class BirthdayViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let birthday: ControlProperty<Date>
        let nextButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let pushNextViewController: ControlEvent<Void>
        let year: BehaviorRelay<Int>
        let month: BehaviorRelay<Int>
        let day: BehaviorRelay<Int>
    }
    
    func transform(input: Input) -> Output {
        let pushNextViewController = input.nextButtonTap
        
        let year = BehaviorRelay(value: 2025)
        let month = BehaviorRelay(value: 2)
        let day = BehaviorRelay(value: 18)
        
        input.birthday
            .bind(with: self) { owner, date in
                let calendar = Calendar.current
                let dateComponents = calendar.dateComponents([
                    .year, .month, .day
                ], from: date)
                year.accept(dateComponents.year ?? 0)
                month.accept(dateComponents.month ?? 0)
                day.accept(dateComponents.day ?? 0)
            }
            .disposed(by: disposeBag)
        
        let output = Output(
            pushNextViewController: pushNextViewController,
            year: year,
            month: month,
            day: day
        )
        
        return output
    }
}
