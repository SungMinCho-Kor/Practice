//
//  SignUpViewController.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 1/13/25.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wordmark")
        
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일 주소 또는 전화번호"
        textField.backgroundColor = .darkGray
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.backgroundColor = .darkGray
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.backgroundColor = .darkGray
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "위치"
        textField.backgroundColor = .darkGray
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let codeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "추천 코드 입력"
        textField.backgroundColor = .darkGray
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "회원가입",
            for: .normal
        )
        button.setTitleColor(
            .black,
            for: .normal
        )
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    private let additionalButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "추가 정보 입력",
            for: .normal
        )
        button.setTitleColor(
            .white,
            for: .normal
        )
        return button
    }()
    private let additionalSwitch: UISwitch = {
        let additionalSwitch = UISwitch()
        additionalSwitch.isOn = true
        additionalSwitch.onTintColor = .systemRed
        return additionalSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setUI()
        autoLayout()
    }
    
}

//MARK: Design
extension SignUpViewController {
    private func setView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUI() {
        [
            logoImageView,
            emailTextField,
            passwordTextField,
            nicknameTextField,
            locationTextField,
            codeTextField,
            signUpButton,
            additionalButton,
            additionalSwitch
        ].forEach(view.addSubview)
    }
    
    private func autoLayout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(100)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(52)
        }
        
        additionalButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(40)
        }
        
        additionalSwitch.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(40)
        }
    }
}
