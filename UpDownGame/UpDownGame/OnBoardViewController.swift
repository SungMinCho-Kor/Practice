//
//  OnBoardViewController.swift
//  UpDownGame
//
//  Created by 조성민 on 1/9/25.
//

import UIKit

final class OnBoardViewController: UIViewController {
    
    @IBOutlet private var bottomSheetTopLineView: UIView!
    @IBOutlet private var bottomView: UIView!
    @IBOutlet private var gameTitleLabel: UILabel!
    @IBOutlet private var gameLabel: UILabel!
    @IBOutlet private var onBoardImageView: UIImageView!
    @IBOutlet private var maxNumberTextField: UITextField!
    @IBOutlet private var maxNumberTextFieldBottomView: UIView!
    @IBOutlet private var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        gameTitleLabelDesign()
        gameLabelDesign()
        onBoardImageViewDesign()
        maxNumberTextFieldDesign()
        maxNumberTextFieldBottomViewDesign()
        startButtonDesign()
        bottomViewDesign()
    }
    
    @IBAction private func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension OnBoardViewController {
    private func viewDesign() {
        view.backgroundColor = .gamePrimary
    }
    
    private func gameTitleLabelDesign() {
        gameTitleLabel.text = "UP DOWN"
        gameTitleLabel.font = .systemFont(
            ofSize: 48,
            weight: .black
        )
        gameTitleLabel.textAlignment = .center
    }
    
    private func gameLabelDesign() {
        gameLabel.text = "GAME"
        gameLabel.font = .systemFont(ofSize: 24)
        gameLabel.textAlignment = .center
    }
    
    private func onBoardImageViewDesign() {
        onBoardImageView.image = UIImage.emotion1
        onBoardImageView.contentMode = .scaleAspectFit
    }
    
    private func maxNumberTextFieldDesign() {
        maxNumberTextField.textAlignment = .center
        maxNumberTextField.placeholder = "1 ~ 999 사이의 숫자를 입력해주세요"
        maxNumberTextField.borderStyle = .none
        maxNumberTextField.keyboardType = .numberPad
        maxNumberTextField.delegate = self
    }
    
    private func maxNumberTextFieldBottomViewDesign() {
        maxNumberTextFieldBottomView.backgroundColor = .white
        maxNumberTextFieldBottomView.alpha = 0.7
    }
    
    private func startButtonDesign() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .black
        configuration.baseForegroundColor = .white
        configuration.title = "시작하기"
        startButton.configuration = configuration
        startButton.isEnabled = false
        startButton.addTarget(
            self,
            action: #selector(startButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func bottomViewDesign() {
        bottomSheetTopLineView.backgroundColor = .black
        bottomSheetTopLineView.alpha = 0.1
        bottomSheetTopLineView.isHidden = true
        bottomView.backgroundColor = .gamePrimary
        self.view.keyboardLayoutGuide.followsUndockedKeyboard = true
        NSLayoutConstraint.activate(
            [
                startButton.bottomAnchor.constraint(
                    equalTo: view.keyboardLayoutGuide.topAnchor,
                    constant: -16
                )
            ]
        )
    }
    
    @objc
    private func startButtonTapped(_ sender: UIButton) {
        let gameViewController = GameViewController()
        guard let maxCountText = maxNumberTextField.text,
              let maxCount = Int(maxCountText) else {
            return
        }
        gameViewController.maxCount = maxCount
        navigationController?.pushViewController(
            gameViewController,
            animated: true
        )
    }
}

extension OnBoardViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let oldString = textField.text,
              let newRange = Range(
                range,
                in: oldString
              ) else {
            print("textField text nil")
            return false
        }
        
        let inputString = string.trimmingCharacters(in: .whitespacesAndNewlines)
        let newString = oldString.replacingCharacters(
            in: newRange,
            with: inputString
        ).trimmingCharacters(in: .whitespacesAndNewlines)
        if newString.isEmpty {
            startButton.isEnabled = false
            return true
        }
        if let number = Int(newString), 0 < number && number <= 999 {
            startButton.isEnabled = true
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldBeginEditing(
        _ textField: UITextField
    ) -> Bool {
        textField.placeholder = ""
        bottomSheetTopLineView.isHidden = false
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.placeholder = "1 ~ 999 사이의 숫자를 입력해주세요"
        bottomSheetTopLineView.isHidden = true
    }
}
