//
//  ViewController.swift
//  FourthWeek
//
//  Created by 조성민 on 1/13/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let nameTextField = UITextField()
    let redView = UIView()
    let greenView = UIView()
    let grayView = UIView()
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = .brown
        return btn
    }()
    
    func makeUIButton() -> UIButton {
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.backgroundColor = .brown
        return btn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLayoutSnapKit2()
        configureButton()
    }

    func frameBasedLayout() {
        view.addSubview(emailTextField)
        emailTextField.frame = CGRect(
            x: 50,
            y: 100,
            width: 293,
            height: 50
        )
        emailTextField.backgroundColor = .lightGray
    }
    
    func autoLayoutConstraints() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .top,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .top,
            multiplier: 1,
            constant: 50
        )
        let leading = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .leading,
            multiplier: 1,
            constant: 50
        )
        let trailing = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .trailing,
            multiplier: 1,
            constant: -50
        )
        let height = NSLayoutConstraint(
            item: passwordTextField,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: 50
        )
//        top.isActive = true
//        leading.isActive = true
//        trailing.isActive = true
//        height.isActive = true
        view.addConstraints([top, leading, trailing, height])
        passwordTextField.backgroundColor = .lightGray
    }

    func autoLayoutAnchor() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 300),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            nameTextField.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        ])
        nameTextField.backgroundColor = .lightGray
    }
    
    func autoLayoutSnapKit() {
        view.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(grayView)
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        grayView.backgroundColor = .gray
        redView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        greenView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(300)
        }
        grayView.snp.makeConstraints { make in
            make.top.equalTo(greenView.snp.bottom).offset(50)
            make.centerX.equalTo(greenView.snp.centerX)
            make.size.equalTo(greenView.snp.size)
        }
    }

    func autoLayoutSnapKit2() {
        view.addSubview(redView)
        view.addSubview(grayView)
        grayView.addSubview(greenView)
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        grayView.backgroundColor = .gray
        redView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalToSuperview()
        }
        grayView.snp.makeConstraints { make in
            make.edges.equalTo(redView).inset(30)
        }
        greenView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func configureButton() {
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.equalTo(redView.snp.top).offset(-10)
            make.centerX.equalTo(redView)
        }
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        let vc = BookViewController()
        present(vc, animated: true)
    }
//    func makeMyButton() -> UIButton
}

