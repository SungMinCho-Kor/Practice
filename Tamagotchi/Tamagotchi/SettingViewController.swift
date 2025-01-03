//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 1/2/25.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var saveBarButton: UIBarButtonItem!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nicknameTextFieldBottomView: UIView!
    
    var previousNickname: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(navigationItem.backBarButtonItem)
        dump(navigationItem.backButtonTitle)
        setStatus()
        viewDesign()
        navigationDesign()
        nicknameTextFieldDesign()
        nicknameTextFieldBottomViewDesign()
    }
    
    func setStatus() {
        previousNickname = UserDefaults.standard.string(forKey: "nickname") ?? "대장"
    }
    
    func viewDesign() {
        view.backgroundColor = .tamagotchiBackground
    }
    
    func navigationDesign() {
        navigationItem.title = "대장님 이름 정하기"
        saveBarButton.title = "저장"
        saveBarButton.tintColor = .tamagotchiPrimary
        saveBarButton.isEnabled = false
    }
    
    func nicknameTextFieldDesign() {
        nicknameTextField.placeholder = "2~6글자로 입력해주세요"
        nicknameTextField.borderStyle = .none
        nicknameTextField.text = previousNickname
        nicknameTextField.font = .boldSystemFont(ofSize: 16)
        nicknameTextField.textColor = .tamagotchiPrimary
    }
    
    func nicknameTextFieldBottomViewDesign() {
        nicknameTextFieldBottomView.backgroundColor = .tamagotchiPrimary
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        guard let nickname = nicknameTextField.text else {
            print("nickname is nil")
            return
        }
        UserDefaults.standard.setValue(nickname, forKey: "nickname")
        previousNickname = nickname
        saveBarButton.isEnabled = false
        let alert = UIAlertController(title: "변경 완료", message: "대장님 이름이 \(nickname)(으)로 변경되었습니다", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func nicknameDidChanged(_ sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if sender.text?.count ?? 0 >= 2 && sender.text?.count ?? 0 <= 6 && previousNickname != sender.text {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func viewTapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
