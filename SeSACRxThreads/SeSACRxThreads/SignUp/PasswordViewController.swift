//
//  PasswordViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PasswordViewController: UIViewController {
   
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let password = BehaviorSubject(value: "1234")
    
    private let disposeBag = DisposeBag()
    
    // Scheduler => Main, Global => GCD
    private let timer = Observable<Int>.interval(
        .seconds(1),
        scheduler: MainScheduler.instance
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        
        bind()
    }
    
    private func bind() {
        
        // 구독 해제 시점을 수동으로 조절
        let incrementValue = timer
            .subscribe(with: self) { owner, value in
                print(value)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
        
//        timer
//            .subscribe(with: self) { owner, value in
//                print(value)
//            } onError: { owner, error in
//                print(error)
//            } onCompleted: { owner in
//                print("onCompleted")
//            } onDisposed: { owner in
//                print("onDisposed")
//            }
//            .disposed(by: disposeBag)

        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
//                self.password.onNext("5678")
                incrementValue.dispose()
                owner.navigationController?.pushViewController(NicknameViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        password
            .bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
         
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
