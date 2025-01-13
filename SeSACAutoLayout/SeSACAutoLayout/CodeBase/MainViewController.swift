//
//  MainViewController.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 1/13/25.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private let signUpButton = UIButton()
    private let nPayButton = UIButton()
    private let searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        configureButtons()
        signUpButton.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside
        )
        nPayButton.addTarget(
            self,
            action: #selector(nPayButtonTapped),
            for: .touchUpInside
        )
        searchButton.addTarget(
            self,
            action: #selector(searchButtonTapped),
            for: .touchUpInside
        )
    }
    
}

//MARK: Design
extension MainViewController {
    private func configureButtons() {
        designButton(
            signUpButton,
            title: "SignUp"
        )
        designButton(
            nPayButton,
            title: "NPAY"
        )
        designButton(
            searchButton,
            title: "SEARCH"
        )
    }
    
    private func setUI() {
        [
            signUpButton,
            nPayButton,
            searchButton
        ].forEach(view.addSubview)
    }
    
    private func setLayout() {
        signUpButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nPayButton.snp.top).offset(-100)
        }
        
        nPayButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nPayButton.snp.bottom).offset(100)
        }
    }
    
    private func designButton(_ button: UIButton, title: String) {
        button.setTitle(
            title,
            for: .normal
        )
        button.backgroundColor = .systemPink
    }
}

//MARK: Objective-C
@objc
extension MainViewController {
    private func signUpButtonTapped(_ sender: UIButton) {
        let signUpViewController = SignUpViewController()
        present(
            signUpViewController,
            animated: true
        )
    }
    
    private func nPayButtonTapped(_ sender: UIButton) {
        
    }
    
    private func searchButtonTapped(_ sender: UIButton) {
        
    }
}
