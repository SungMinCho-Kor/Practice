//
//  ValidationViewController.swift
//  RxExample
//
//  Created by 조성민 on 2/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ValidationViewController: UIViewController {

    private let usernameTitleLabel = UILabel()
    private let username = UITextField()
    private let usernameValid = UILabel()
    private let passwordTitleLabel = UILabel()
    private let password = UITextField()
    private let passwordValid = UILabel()
    private let doSomething = UIButton()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        bind()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        usernameTitleLabel.text = "Username"
        passwordTitleLabel.text = "Password"
        
        username.borderStyle = .roundedRect
        password.borderStyle = .roundedRect
        
        doSomething.setTitle("Do something", for: .normal)
        doSomething.setTitleColor(.black, for: .normal)
        doSomething.backgroundColor = .green
        
        usernameValid.textColor = .systemRed
        passwordValid.textColor = .systemRed
        
        usernameValid.text = "Username has to be at least 5 characters"
        passwordValid.text = "Password has to be at least 5 characters"
        
        
        [
            usernameTitleLabel,
            username,
            usernameValid,
            passwordTitleLabel,
            password,
            passwordValid,
            doSomething
        ].forEach(view.addSubview)
        
        usernameTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        username.snp.makeConstraints { make in
            make.top.equalTo(usernameTitleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        usernameValid.snp.makeConstraints { make in
            make.top.equalTo(username.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameValid.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        password.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        passwordValid.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        doSomething.snp.makeConstraints { make in
            make.top.equalTo(passwordValid.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    private func bind() {
        let usernameValidation = username
            .rx
            .text
            .orEmpty
            .withUnretained(self)
            .map { onwer, value in
                value.count > 5
            }
        
        usernameValidation
            .bind(to: usernameValid.rx.isHidden)
            .disposed(by: disposeBag)
        
        let passwordValidation = password
            .rx
            .text
            .orEmpty
            .withUnretained(self)
            .map { onwer, value in
                value.count > 5
            }
        
        passwordValidation
            .bind(to: passwordValid.rx.isHidden)
            .disposed(by: disposeBag)
        
        usernameValidation
            .bind(to: password.rx.isEnabled)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            passwordValidation,
            usernameValidation
        )
        .withUnretained(self)
        .map { owner, value in
            value.0 && value.1
        }
        .bind(to: doSomething.rx.isEnabled)
        .disposed(by: disposeBag)
        
        doSomething
            .rx
            .tap
            .bind(with: self) { owner, _ in
                print("AA")
            }
            .disposed(by: disposeBag)
    }
}
