//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    
    let emailText = Observable.just("abc@naver.com")
    let disposeBag = DisposeBag()
    
    let backgroundColor = Observable.just(UIColor.lightGray)
    
    let signUpTitle = Observable.just("회원이 아직 아니십니까?")
    let signUpTitleColor = Observable.just(UIColor.red)
    
    func bindBackgroundColor() {
        backgroundColor
            .subscribe(with: self) { owner, value in
                owner.view.backgroundColor = value
            } onError: { owner, error in
                print(#function, error)
            } onCompleted: { owner in
                print(#function, "onComplete")
            } onDisposed: { owner in
                print(#function, "onDispose")
            }
            .disposed(by: disposeBag)
        
        backgroundColor
            .bind(with: self) { owner, value in
                owner.view.backgroundColor = value
            }
            .disposed(by: disposeBag)
        
        backgroundColor
            .bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)
        
//        backgroundColor
//            .subscribe { color in
//                self.view.backgroundColor = color
//            } onError: { error in
//                print(#function, error)
//            } onCompleted: {
//                print(#function, "onComplete")
//            } onDisposed: {
//                print(#function, "onDispose")
//            }
//            .disposed(by: disposeBag)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        bindBackgroundColor()
        signUpButton
            .rx
            .tap // 여기까지 하면 Observable이 만들어짐
            .subscribe { _ in
                self.navigationController?.pushViewController(SignUpViewController(), animated: true)
            } onError: { error in
                print("signUpButton onError")
            } onCompleted: {
                print("signUpButton onCompleted")
            } onDisposed: {
                print("signUpButton onDisposed")
            }
            .disposed(by: disposeBag)
        
        emailText.subscribe { value in
            self.emailTextField.text = value
            print("email onNext")
        } onError: { error in
            print("email onError")
        } onCompleted: {
            print("email onCompleted")
        } onDisposed: {
            print("email onDisposed")
        }
        .disposed(by: disposeBag)

    }
    
    func configure() {
//        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
//        signUpButton.setTitleColor(Color.black, for: .normal)
        signUpTitle
            .bind(to: signUpButton.rx.title())
            .disposed(by: disposeBag)
        signUpTitleColor
            .bind(with: self) { owner, value in
                owner.signUpButton.setTitleColor(value, for: .normal)
            }
            .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
