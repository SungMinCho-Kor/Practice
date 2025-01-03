//
//  SignUpViewController.swift
//  Assignment2
//
//  Created by 조성민 on 12/26/24.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var textFieldList: [UITextField]!
    var placesholderList: [String] = [
        "이메일 주소 또는 전화번호",
        "비밀번호",
        "닉네임",
        "위치",
        "추천 코드 입력"
    ]
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var additionalSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldListDesign()
        signUpButtonDesign()
        additionalSwitchDesign()
    }
    
    func textFieldListDesign() {
        for idx in 0...4 {
            textFieldList[idx].placeholder = placesholderList[idx]
            textFieldList[idx].textColor = .white
            textFieldList[idx].textAlignment = .center
            textFieldList[idx].borderStyle = .roundedRect
            textFieldList[idx].backgroundColor = .darkGray
            if idx == 1 {
                textFieldList[idx].isSecureTextEntry = true
            }
        }
    }
    
    func signUpButtonDesign() {
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = .white
    }
    
    func additionalSwitchDesign() {
        additionalSwitch.setOn(false, animated: true)
        additionalSwitch.onTintColor = .red
        additionalSwitch.thumbTintColor = .white
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
    
}
