//
//  OnboardingViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class OnboardingViewController: BaseViewController {
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(button)
    }
    
    override func configureLayout() {
        button.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
        }
    }
    
    override func configureViews() {
        view.backgroundColor = .darkGray
        
        button.layer.cornerRadius = 25
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle("시작하기", for: .normal)
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }
 
    @objc private func buttonTapped() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            print(#function, "Window Scene Wrong")
            return
        }
        UserDefaultsManager.shared.isOnboardDone = true
        window.rootViewController = UINavigationController(
            rootViewController: ProfileViewController()
        )
        window.makeKeyAndVisible()
    }
}
