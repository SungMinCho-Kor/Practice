//
//  NicknameViewController.swift
//  FirstApp
//
//  Created by 조성민 on 12/26/24.
//

import UIKit

class NicknameViewController: UIViewController {

    @IBOutlet var tempView: UIView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var clickButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempView.backgroundColor = .red
        tempView.layer.cornerRadius = 10
        tempView.layer.masksToBounds = false
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요"
        nicknameTextField.keyboardType = .emailAddress
        nicknameTextField.text = "고래밥"
        nicknameTextField.borderStyle = .none
    }
    
    @IBAction func nickNameTextFieldDidEndOnExit(_ sender: UITextField) {
        dump(#function)
    }
    
    @IBAction func nickNameTextFieldEditingChanged(_ sender: UITextField) {
        dump(#function)
        print(sender.text?.count)
    }
    
    @IBAction func clickButtonTapped(_ sender: UIButton) {
        resultLabel.text = "\(nicknameTextField.text!) 입력했어요"
        view.endEditing(true)
    }
}
