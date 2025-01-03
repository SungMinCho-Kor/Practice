//
//  ViewController.swift
//  BMICalculator
//
//  Created by 조성민 on 12/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var largeTitleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var nicknameAnnounceLabel: UILabel!
    @IBOutlet var nicknameContainerView: UIView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var heightAnnounceLabel: UILabel!
    @IBOutlet var heightContainerView: UIView!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightAnnounceLabel: UILabel!
    @IBOutlet var weightContainerView: UIView!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var showWeightButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var checkResultButton: UIButton!
    
    let noInputAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "키, 몸무게 입력 오류",
            message: "키와 몸무게 모두 입력해주세요",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        return alert
    }()
    
    let wrongHeightAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "키 입력 오류",
            message: "키는 140이상 200이하의 정수로 입력해주세요",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        return alert
    }()
    
    let wrongWeightAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "몸무게 입력 오류",
            message: "몸무게는 40이상 130이하의 정수로 입력해주세요",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        return alert
    }()
    
    let resetAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "초기화 완료",
            message: "닉네임, 키, 몸무게를 초기화했습니다.",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        largeTitleLabelDesign()
        subtitleLabelDesign()
        characterImageViewDesign()
        announceLabelDesign(nicknameAnnounceLabel, text: "닉네임이 어떻게 되시나요?")
        announceLabelDesign(heightAnnounceLabel, text: "키가 어떻게 되시나요? (cm)")
        announceLabelDesign(weightAnnounceLabel, text: "몸무게는 어떻게 되시나요? (kg)")
        containerViewDesign(nicknameContainerView)
        containerViewDesign(heightContainerView)
        containerViewDesign(weightContainerView)
        textFieldDesign(nicknameTextField)
        textFieldDesign(heightTextField, isNumber: true)
        textFieldDesign(weightTextField, isSecret: true, isNumber: true)
        showWeightButtonDesign()
        resetButtonDesign()
        randomButtonDesign()
        checkResultButtonDesign()
        loadUserInformation()
    }
    
    func largeTitleLabelDesign() {
        largeTitleLabel.text = "BMI Calculator"
        largeTitleLabel.font = .boldSystemFont(ofSize: 26)
    }
    
    func subtitleLabelDesign() {
        subtitleLabel.text = "당신의 BMI 지수를 알려드릴게요."
        subtitleLabel.numberOfLines = 2
    }
    
    func characterImageViewDesign() {
        characterImageView.image = .character
    }
    
    func announceLabelDesign(_ label: UILabel, text: String = "") {
        label.text = text
    }
    
    func containerViewDesign(_ containerView: UIView) {
        containerView.layer.borderColor = UIColor.black.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 22
    }
    
    func textFieldDesign(_ textField: UITextField, isSecret: Bool = false, isNumber: Bool = false) {
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 20)
        textField.isSecureTextEntry = isSecret
        if isNumber {
            textField.keyboardType = .numberPad
        }
    }
    
    func showWeightButtonDesign() {
        showWeightButton.setImage(UIImage(systemName: "eye"), for: .normal)
        showWeightButton.tintColor = .gray
    }
    
    func resetButtonDesign() {
        resetButton.setTitle("초기화하기", for: .normal)
        resetButton.tintColor = .red
        resetButton.contentHorizontalAlignment = .leading
    }
    
    func randomButtonDesign() {
        randomButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomButton.tintColor = .red
        randomButton.contentHorizontalAlignment = .trailing
    }
    
    func checkResultButtonDesign() {
        checkResultButton.setTitle("결과 확인", for: .normal)
        checkResultButton.tintColor = .white
        checkResultButton.backgroundColor = .purple
        checkResultButton.layer.cornerRadius = 16
    }
    
    @IBAction func textFieldReturned(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    @IBAction func showWeightButtonTapped(_ sender: UIButton) {
        weightTextField.isSecureTextEntry.toggle()
        showWeightButton.setImage(UIImage(systemName: weightTextField.isSecureTextEntry ? "eye" : "eye.slash"), for: .normal)
    }
    
    @IBAction func viewTapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        nicknameTextField.text = ""
        heightTextField.text = ""
        weightTextField.text = ""
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "height")
        UserDefaults.standard.removeObject(forKey: "weight")
        present(resetAlert, animated: true)
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        heightTextField.text = "\(Int.random(in: 140...200))"
        weightTextField.text = "\(Int.random(in: 40...130))"
    }
    
    @IBAction func checkResultButtonTapped(_ sender: UIButton) {
        guard heightTextField.text?.isEmpty == false && weightTextField.text?.isEmpty == false else {
            present(noInputAlert, animated: true)
            return
        }
        guard let heightText = heightTextField.text,
              let height = Int(heightText),
              height >= 140,
              height <= 200 else {
            present(wrongHeightAlert, animated: true)
            print("height is not correct")
            return
        }
        guard let weightText = weightTextField.text,
              let weight = Int(weightText),
              weight >= 40,
              weight <= 130 else {
            present(wrongWeightAlert, animated: true)
            print("weight is not correct")
            return
        }
        
        let bmi = Double(weight) / (Double(height * height) / Double(10000))
        var message = ""
        if let nickname =  nicknameTextField.text, nickname.isEmpty == false {
            message = "\(nickname)님의 "
            UserDefaults.standard.setValue(nickname, forKey: "nickname")
        }
        message += "BMI는 \(Double(Int(bmi * 10))/Double(10)) 입니다"
        UserDefaults.standard.setValue(height, forKey: "height")
        UserDefaults.standard.setValue(weight, forKey: "weight")
        let alert = UIAlertController(
            title: "BMI",
            message: message,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func loadUserInformation() {
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            nicknameTextField.text = nickname
        }
        if let height = UserDefaults.standard.string(forKey: "height") {
            heightTextField.text = height
        }
        if let weight = UserDefaults.standard.string(forKey: "weight") {
            weightTextField.text = weight
        }
    }
    
    @IBAction func numberTextFieldEditingChanged(_ sender: UITextField) {
        guard let text = sender.text else {
            print("number text is nil")
            return
        }
        if Int(text) == nil {
            sender.text = ""
        }
    }
    
}

