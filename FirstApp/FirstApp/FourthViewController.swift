//
//  FourthViewController.swift
//  FirstApp
//
//  Created by 조성민 on 12/27/24.
//

import UIKit

class FourthViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var oneTextField: UITextField!
    @IBOutlet var twoTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabelDesign()
        textFieldDesign(nicknameTextField, ph: "닉네임 써줘")
        textFieldDesign(oneTextField, ph: "이메일써줘")
        textFieldDesign(twoTextField, ph: "비번 써줘")
    }
    
    func textFieldDesign(
        _ textField: UITextField,
        ph placeholder: String,
        textColor: UIColor? = nil
    ) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.textColor = textColor
        textField.backgroundColor = .systemCyan
    }
    
    func resultLabelDesign() {
        resultLabel.backgroundColor = .lightGray
        resultLabel.numberOfLines = 0
        resultLabel.text = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
