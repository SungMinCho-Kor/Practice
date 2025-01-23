//
//  ClosureViewController.swift
//  FiveWeek
//
//  Created by 조성민 on 1/23/25.
//

import UIKit

class ClosureViewController: UIViewController {
    
    var contents: (() -> Void)?
    
     let emailTextField = SignTextField(placeholderText: "Notification을 통한 값 전달")
     let nextButton = PointButton(title: "전달하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureLayout()
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        contents?()
    }
    
    @objc func nextButtonTapped() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(nextButton)
         
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
