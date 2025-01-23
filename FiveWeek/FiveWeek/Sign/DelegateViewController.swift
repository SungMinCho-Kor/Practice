//
//  DelegateViewController.swift
//  FiveWeek
//
//  Created by 조성민 on 1/23/25.
//

import UIKit

final class DelegateViewController: UIViewController {
    
    weak var delegate: PassDataDelegate?
    let statusLabel = UILabel()
    let nextButton = PointButton(title: "처음으로")
    let profileButton = PointButton(title: "프로필")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureLayout()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(jackRecievedNotifiation),
            name: NSNotification.Name("signal"),
            object: nil
        )
    }
    
    deinit {
        print(self)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(EmailViewController(), animated: true)
    }
    
    @objc func profileButtonTapped() {
        //        NotificationCenter.default.post(
        //            name: NSNotification.Name("sesac"),
        //            object: nil,
        //            userInfo: [
        //                "nickname": "나야",
        //                "value": statusLabel.text ?? ""
        //            ]
        //        )
        let vc = ClosureViewController()
        vc.contents = {
            print(self)
        }
        navigationController?.pushViewController(
            vc,
            animated: true
        )
    }
    
    func sample() {
        print(#function)
    }
    
    @objc func jackRecievedNotifiation(_ sender: NSNotification) {
        if let text = sender.userInfo?["value"] as? String {
            statusLabel.text = text
        } else {
            
        }
    }
    
    func configureLayout() {
        view.addSubview(statusLabel)
        view.addSubview(nextButton)
        view.addSubview(profileButton)
        
        statusLabel.text = "메인 화면"
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(statusLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        profileButton.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
    }
    
}

