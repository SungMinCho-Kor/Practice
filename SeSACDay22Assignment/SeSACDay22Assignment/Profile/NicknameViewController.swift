//
//  NicknameViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class NicknameViewController: BaseViewController {
    private let textField = UITextField()
    
    var nicknameContents: ((String) -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            textField.text = nickname
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nicknameContents?(textField.text ?? "")
    }
    
    @objc func okButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    override func configureViews() {
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "확인",
            style: .plain,
            target: self,
            action: #selector(okButtonTapped)
        )
        view.backgroundColor = .white
        
        textField.placeholder = "닉네임을 입력해주세요"
    }
}
