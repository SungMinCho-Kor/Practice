//
//  MainViewController.swift
//  ThreeSixNine
//
//  Created by 조성민 on 1/8/25.
//

import UIKit

final class MainViewController: UIViewController {
    @IBOutlet private var gameTitleLabel: UILabel!
    @IBOutlet private var maxNumberTextField: UITextField!
    @IBOutlet private var clapsTextView: UITextView!
    @IBOutlet private var resultClapLabel: UILabel!
    private let numberPickerView = UIPickerView()
    private let maxNumber = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTitleLabelDesign()
        maxNumberTextFieldDesign()
        clapsTextViewDesign()
        resultClapLabelDesign()
        configureNumberPickerView()
    }
    
    private func gameTitleLabelDesign() {
        gameTitleLabel.text = "369 게임"
        gameTitleLabel.textAlignment = .center
        gameTitleLabel.font = .boldSystemFont(ofSize: 32)
    }
    
    private func maxNumberTextFieldDesign() {
        maxNumberTextField.borderStyle = .line
        maxNumberTextField.inputView = numberPickerView
        maxNumberTextField.tintColor = .clear
        maxNumberTextField.delegate = self
        maxNumberTextField.textAlignment = .center
        maxNumberTextField.placeholder = "최대 숫자를 입력해주세요"
        maxNumberTextField.font = .systemFont(ofSize: 20)
    }
    
    private func clapsTextViewDesign() {
        clapsTextView.delegate = self
        clapsTextView.borderStyle = .none
        clapsTextView.textAlignment = .center
        clapsTextView.textColor = .gray
        clapsTextView.text = "박수 짝짝"
    }
    
    private func resultClapLabelDesign() {
        resultClapLabel.textAlignment = .center
        resultClapLabel.numberOfLines = 0
        resultClapLabel.font = .systemFont(
            ofSize: 32,
            weight: .bold
        )
        resultClapLabel.text = "총 박수는?!"
    }
    
    private func configureNumberPickerView() {
        numberPickerView.delegate = self
        numberPickerView.dataSource = self
    }
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return maxNumber
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return String(maxNumber - row)
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        maxNumberTextField.text = String(maxNumber - row)
        let clapsText = Array<String>((1...(maxNumber - row)).map({String($0)}))
            .joined(separator: ", ")
            .replacingOccurrences(
                of: "[369]",
                with: "👏",
                options: .regularExpression
            )
        clapsTextView.text = clapsText
        resultClapLabel.text = "숫자 \(maxNumber - row)까지 총 박수는 \(clapsText.count(where: {$0 == "👏"}))입니다."
    }
}

extension MainViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("a")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.frame = .init(origin: .zero, size: estimatedSize)
        return true
    }
}

extension MainViewController: UITextFieldDelegate {
    // TODO: edit
}
