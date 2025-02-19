//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    let disposeBag = DisposeBag()
    
    let emailPlaceholder = Observable.just("이메일을 입력해주세요")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        bindEmailPlaceholder()
        
//        emailTextField.rx.text.orEmpty
//            .bind(with: self) { owner, value in
//                let trigger = value.count >= 4
//                owner.nextButton.isHidden = !trigger
//                owner.validationButton.isEnabled = trigger
//            }
//            .disposed(by: disposeBag)
        
//        emailTextField
//            .rx
//            .text
//            .orEmpty
//            .map { value in
//                value.count >= 4
//            }
//            .bind(to: nextButton.rx.isHidden, validationButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        emailTextField
            .rx
            .text
            .orEmpty
            .map { value in
                value.count >= 4
            }
            
//            .bind(with: self) { owner, value in
//                let trigger = value.count >= 4
//                owner.nextButton.isHidden = !trigger
//                owner.validationButton.isEnabled = trigger
//            }
//            .disposed(by: disposeBag)
        
        validationButton.rx.tap.bind(with: self) { owner, _ in
            print("vald")
        }
        .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind { [weak self] _ in
                self?.navigationController?.pushViewController(PasswordViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }

    func operatorExample() {
        let items = [1, 3, 5, 11, 15]
        Observable
            .repeatElement(items)
            .take(10)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            }

    }
    
    func bindEmailPlaceholder() {
        emailPlaceholder
            .bind(to: emailTextField.rx.placeholder)
            .disposed(by: disposeBag)
    }
    
    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
