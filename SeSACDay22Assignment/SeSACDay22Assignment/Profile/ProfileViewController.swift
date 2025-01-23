//
//  ProfileViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class ProfileViewController: BaseViewController {
    private let nicknameButton = UIButton()
    private let birthdayButton = UIButton()
    private let levelButton = UIButton()
    
    private let nicknameLabel = UILabel()
    private let birthdayLabel = UILabel()
    private let levelLabel = UILabel()
    
    private let alertController: UIAlertController = {
        let alert = UIAlertController(
            title: nil,
            message: "정말 탈퇴하시겠습니까?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "탈퇴", style: .destructive, handler: { _ in
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                print(#function, "Window Scene Wrong")
                return
            }
            UserDefaultsManager.shared.isOnboardDone = false
            UserDefaults.standard.removeObject(forKey: "level")
            UserDefaults.standard.removeObject(forKey: "nickname")
            UserDefaults.standard.removeObject(forKey: "birthday")
            window.rootViewController = UINavigationController(
                rootViewController: OnboardingViewController()
            )
            window.makeKeyAndVisible()
        }))
        return alert
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            nicknameLabel.text = nickname
            nicknameLabel.textColor = .black
        } else {
            nicknameLabel.text = "NO NAME"
            nicknameLabel.textColor = .lightGray
        }
        if let birthday = UserDefaults.standard.string(forKey: "birthday") {
            birthdayLabel.text = birthday
            birthdayLabel.textColor = .black
        } else {
            birthdayLabel.text = "NO DATE"
            birthdayLabel.textColor = .lightGray
        }
        if let level = UserDefaults.standard.string(forKey: "level") {
            levelLabel.text = level
            levelLabel.textColor = .black
        } else {
            levelLabel.text = "NO LEVEL"
            levelLabel.textColor = .lightGray
        }
    }
    
    @objc private func okButtonTapped() {
        present(
            alertController,
            animated: true
        )
    }
    
    override func configureHierarchy() {
        [
            nicknameButton,
            birthdayButton,
            levelButton,
            nicknameLabel,
            birthdayLabel,
            levelLabel
        ].forEach(view.addSubview)
    }
    
    override func configureLayout() {
        nicknameButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(nicknameButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        levelButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(birthdayButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(levelButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
    }
    
    override func configureViews() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "탈퇴하기",
            style: .plain,
            target: self,
            action: #selector(okButtonTapped)
        )
        view.backgroundColor = .white
        
        nicknameButton.setTitleColor(.black, for: .normal)
        birthdayButton.setTitleColor(.black, for: .normal)
        levelButton.setTitleColor(.black, for: .normal)
        
        nicknameButton.setTitle("닉네임", for: .normal)
        birthdayButton.setTitle("생일", for: .normal)
        levelButton.setTitle("레벨", for: .normal)
        
        nicknameButton.addTarget(
            self,
            action: #selector(nicknameButtonTapped),
            for: .touchUpInside
        )
        birthdayButton.addTarget(
            self,
            action: #selector(birthdayButtonTapped),
            for: .touchUpInside
        )
        levelButton.addTarget(
            self,
            action: #selector(levelButtonTapped),
            for: .touchUpInside
        )
        
        nicknameLabel.textAlignment = .right
        birthdayLabel.textAlignment = .right
        levelLabel.textAlignment = .right
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(receiveLevel),
            name: NSNotification.Name("level"),
            object: nil
        )
    }
    
    @objc private func nicknameButtonTapped() {
        let nicknameViewController = NicknameViewController()
        nicknameViewController.nicknameContents = { [weak self] nickname in
            self?.nicknameLabel.text = nickname
            self?.nicknameLabel.textColor = .black
            UserDefaults.standard.set(nickname, forKey: "nickname")
        }
        navigationController?.pushViewController(
            nicknameViewController,
            animated: true
        )
    }
    
    @objc private func birthdayButtonTapped() {
        let birthdayViewController = BirthdayViewController()
        birthdayViewController.delegate = self
        navigationController?.pushViewController(
            birthdayViewController,
            animated: true
        )
    }
    
    @objc private func levelButtonTapped() {
        let levelViewController = LevelViewController()
        navigationController?.pushViewController(
            levelViewController,
            animated: true
        )
    }
    
    @objc private func receiveLevel(_ sender: Notification) {
        guard let level = sender.userInfo?["level"] as? String else {
            return
        }
        levelLabel.text = level
        levelLabel.textColor = .black
        UserDefaults.standard.set(level, forKey: "level")
    }
}

extension ProfileViewController: PassDataDelegate {
    func passBirthday(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. M. d"
        let text = dateFormatter.string(from: date)
        birthdayLabel.text = text
        birthdayLabel.textColor = .black
        UserDefaults.standard.set(text, forKey: "birthday")
    }
}
