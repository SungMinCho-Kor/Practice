//
//  CurrencyViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit

final class CurrencyViewController: UIViewController {
    private let viewModel = CurrencyViewModel()
    
    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(
            ofSize: 16,
            weight: .medium
        )
        return label
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "원화 금액을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    private let convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle(
            "환전하기",
            for: .normal
        )
        button.setTitleColor(
            .white,
            for: .normal
        )
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(
            ofSize: 16,
            weight: .bold
        )
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(
            ofSize: 16,
            weight: .medium
        )
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        bind()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        exchangeRateLabel.text = "현재 환율: 1 USD = \(viewModel.exchangeRate.formatted()) KRW"
        
        [
            exchangeRateLabel,
            amountTextField,
            convertButton,
            resultLabel
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        exchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        convertButton.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(convertButton.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupActions() {
        convertButton.addTarget(
            self,
            action: #selector(convertButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func bind() {
        viewModel.outputResultText.bind { [weak self] text in
            self?.resultLabel.text = text
        }
    }
    
    @objc private func convertButtonTapped() {
        viewModel.inputAmountText.value = amountTextField.text
    }
}
