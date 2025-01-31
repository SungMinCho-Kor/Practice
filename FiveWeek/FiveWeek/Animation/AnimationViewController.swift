//
//  AnimationViewController.swift
//  FiveWeek
//
//  Created by 조성민 on 1/31/25.
//

import UIKit
import Lottie

final class AnimationViewController: UIViewController {
    private let animationImageView = LottieAnimationView(name: "Animation - 1738288353389")
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton = UIButton()
//    = {
//        let button = UIButton(type: .system)
//        button.setTitle("로그인", for: .normal)
//        button.backgroundColor = .systemPurple
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 5
//        return button
//    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "계정이 없으신가요? 회원가입"
        label.textColor = .systemBlue
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupAnimations()
    }
    
    private func setupLoginButton() {
        
    }
    
    private func setupAnimations() {
        emailTextField.alpha = 0
        passwordTextField.alpha = 0
        logoImageView.alpha = 0
        loginButton.alpha = 0
        signUpLabel.alpha = 0
        logoImageView.transform = CGAffineTransform(
            scaleX: 0.1,
            y: 0.1
        )
        
        UIView.animate(withDuration: 5) {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = CGAffineTransform(rotationAngle: 360)
        } completion: { _ in
            self.animationEmailTextField()
        }
    }
    
    private func animationEmailTextField() {
        UIView.animate(withDuration: 3) {
            self.emailTextField.alpha = 1
        } completion: { _ in
            self.animationPasswordTextField()
        }
    }
    
    private func animationPasswordTextField() {
        UIView.animate(withDuration: 3) {
            self.passwordTextField.alpha = 1
        } completion: { _ in
            self.animationLoginButton()
        }
    }
    
    private func animationLoginButton() {
        UIView.animate(withDuration: 3) {
            self.loginButton.alpha = 1
        } completion: { _ in
            self.animationSignUpLabel()
        }
    }
    
    private func animationSignUpLabel() {
        UIView.animate(withDuration: 3) {
            self.signUpLabel.alpha = 1
        } completion: { _ in
            self.animationImageView.play()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [logoImageView, emailTextField, passwordTextField, loginButton, signUpLabel, animationImageView]
            .forEach { view.addSubview($0) }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.height.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.height.equalTo(emailTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(44)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        animationImageView.snp.makeConstraints { make in
            make.top.equalTo(signUpLabel.snp.bottom)
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }
}
