//
//  ViewController.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 12/31/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var textFieldList: [UITextField]!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var additionalButton: UIButton!
    @IBOutlet var additionalSwitch: UISwitch!
    
    var placeHolderList: [String] = [
        "이메일 주소 또는 전화번호",
        "비밀번호",
        "닉네임",
        "위치",
        "추천 코드 입력"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageViewDesign()
        textFieldDesign()
        signUpButtonDesign()
        additionalButtonDesign()
        additionalSwitchDesign()
    }
    
    func logoImageViewDesign() {
        logoImageView.image = .wordmark
    }
    
    func textFieldDesign() {
        for idx in 0...4 {
            textFieldList[idx].placeholder = placeHolderList[idx]
            textFieldList[idx].backgroundColor = .darkGray
            textFieldList[idx].layer.cornerRadius = 5
            textFieldList[idx].textAlignment = .center
        }
    }
    
    func signUpButtonDesign() {
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 6
    }
    
    func additionalButtonDesign() {
        additionalButton.setTitle("추가 정보 입력", for: .normal)
        additionalButton.setTitleColor(.white, for: .normal)
    }
    
    func additionalSwitchDesign() {
        additionalSwitch.setOn(false, animated: false)
        additionalSwitch.onTintColor = .systemRed
    }
    
}

