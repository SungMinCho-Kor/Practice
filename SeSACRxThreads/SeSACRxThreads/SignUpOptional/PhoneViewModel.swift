//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/19/25.
//

import RxSwift
import RxCocoa

final class PhoneViewModel {
    struct Input {
        let nextButtonTapped: ControlEvent<Void>
        let phoneText: ControlProperty<String?>
    }
    
    struct Output {
        let pushNicknameViewController: ControlEvent<Void>
        let nextButtonTitle: Observable<String>
        let validation: Observable<Bool>
    }
    
    init() {
        print(#function, self)
    }
    
    deinit {
        print(#function, self)
    }
    
    func transform(input: Input) -> Output {
        let valid = input.phoneText.orEmpty.map { $0.count >= 8 }
        let output = Output(
            pushNicknameViewController: input.nextButtonTapped,
            nextButtonTitle: .just("연락처는 8자 이상"), validation: valid
        )
        
        return output
    }
}
