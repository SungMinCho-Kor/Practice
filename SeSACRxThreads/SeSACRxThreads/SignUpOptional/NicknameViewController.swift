//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    private let disposeBag = DisposeBag()
    
    let recommadList = [
        "고래밥",
        "칙촉",
        "상어",
        "악어",
        "누가바"
    ]
    
//    let nickname = Observable.just("고라고라")
    let nickname = BehaviorSubject(value: "고래밥")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
//        testPublishSubject()
        testBehaviorSubject()
    }
    
    func testPublishSubject() {
        let subject = PublishSubject<Int>()
        
        subject.onNext(3)
        subject.onNext(5)
        
        subject
            .subscribe(with: self) { owner, value in
                print(#function, value)
            } onError: { owner, error in
                print(#function, error)
            } onCompleted: { owner in
                print(#function, "onCompleted")
            } onDisposed: { owner in
                print(#function, "onDisposed")
            }
            .disposed(by: disposeBag)
        
        subject.onNext(1)
        subject.onNext(7)
        subject.onCompleted()
        subject.onNext(4)
    }
    
    func testBehaviorSubject() {
        let subject = BehaviorSubject(value: 0)
        
        subject.onNext(3)
        subject.onNext(5)
        
        subject
            .subscribe(with: self) { owner, value in
                print(#function, value)
            } onError: { owner, error in
                print(#function, error)
            } onCompleted: { owner in
                print(#function, "onCompleted")
            } onDisposed: { owner in
                print(#function, "onDisposed")
            }
            .disposed(by: disposeBag)
        
        subject.onNext(1)
        subject.onNext(7)
        subject.onCompleted()
        subject.onNext(4)
    }

    private func bind() {
        nickname.subscribe(with: self) { owner, value in
            owner.nicknameTextField.text = value
        } onError: { owner, error in
            print(error)
        } onCompleted: { owner in
            print("onCompleted")
        } onDisposed: { owner in
            print("onDisposed")
        }
        .disposed(by: disposeBag)
        
//        nextButton.rx.tap
//            .withUnretained(self)
//            .map { owner, _ in
//                owner.recommadList.randomElement()!
//            }
//            .bind(to: nickname)
//            .disposed(by: disposeBag)
        
//        nextButton.rx.tap
//            .withLatestFrom(Observable.just(recommadList.randomElement()!))
//            .flatmap
//            .bind(to: nickname)
//            .disposed(by: disposeBag)
        
        
    }
    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
