//
//  NPayViewController.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 1/13/25.
//

import UIKit
import SnapKit

final class NPayViewController: UIViewController {
    private let topButtonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 26
        view.clipsToBounds = true
        return view
    }()
    private let membershipButton: UIButton = {
        var attributedString = AttributedString("멤버십")
        attributedString.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = attributedString
        configuration.baseForegroundColor = .darkGray
        configuration.baseBackgroundColor = .clear
        let button = UIButton(configuration: configuration)
        return button
    }()
    private let payHereButton: UIButton = {
        var attributedString = AttributedString("현장결제")
        attributedString.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = attributedString
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .darkGray
        let button = UIButton(configuration: configuration)
        return button
    }()
    private let couponButton: UIButton = {
        var attributedString = AttributedString("쿠폰")
        attributedString.font = UIFont.systemFont(
            ofSize: 20,
            weight: .bold
        )
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = attributedString
        configuration.baseForegroundColor = .darkGray
        configuration.baseBackgroundColor = .clear
        let button = UIButton(configuration: configuration)
        return button
    }()
    private let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "npay")
        return imageView
    }()
    private let toggleButton: UIButton = {
        var attributedString = AttributedString("국내")
        attributedString.font = UIFont.systemFont(ofSize: 12)
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = attributedString
        configuration.image = UIImage(systemName: "arrowtriangle.down.fill")?
            .applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 6))
        configuration.baseForegroundColor = .darkGray
        configuration.imagePlacement = .trailing
        configuration.imagePadding = .zero
        configuration.titlePadding = .zero
        let button = UIButton(configuration: configuration)
        return button
    }()
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "xmark"),
            for: .normal
        )
        button.tintColor = .black
        return button
    }()
    private let lockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock")
        return imageView
    }()
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let payHereUseButton: UIButton = {
        var attributedString = AttributedString("바로결제 사용하기")
        attributedString.font = UIFont.systemFont(
            ofSize: 16,
            weight: .semibold
        )
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = attributedString
        configuration.baseForegroundColor = .black
        configuration.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(
            .systemGreen,
            renderingMode: .alwaysOriginal
        )
        configuration.imagePlacement = .leading
        let button = UIButton(configuration: configuration)
        return button
    }()
    private let okButton: UIButton = {
        var attributedString = AttributedString("확인")
        attributedString.font = UIFont.systemFont(
            ofSize: 16,
            weight: .semibold
        )
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = attributedString
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .systemGreen
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setUI()
        setLayout()
    }
}

//MARK: Design
extension NPayViewController {
    private func setView() {
        view.backgroundColor = .systemBackground
    }
    
    private func setUI() {
        [
            topButtonContainerView,
            popupView
        ].forEach(view.addSubview)
        [
            membershipButton,
            payHereButton,
            couponButton
        ].forEach(topButtonContainerView.addSubview)
        [
            logoImageView,
            toggleButton,
            closeButton,
            lockImageView,
            mainLabel,
            payHereUseButton,
            okButton
        ].forEach(popupView.addSubview)
    }
    
    private func setLayout() {
        topButtonContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
        
        membershipButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(topButtonContainerView.snp.width).multipliedBy(0.3)
            make.trailing.equalTo(payHereButton.snp.leading).offset(-6)
            make.centerY.equalToSuperview()
        }
        
        payHereButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(topButtonContainerView.snp.width).multipliedBy(0.3)
            make.center.equalToSuperview()
        }
        
        couponButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(topButtonContainerView.snp.width).multipliedBy(0.3)
            make.leading.equalTo(payHereButton.snp.trailing).offset(6)
            make.centerY.equalToSuperview()
        }
        
        popupView.snp.makeConstraints { make in
            make.top.equalTo(topButtonContainerView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(400)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
//            make.width.equalTo(60)
//            make.height.equalTo(30)
        }
        
        toggleButton.snp.makeConstraints { make in
            make.leading.equalTo(logoImageView.snp.trailing)
            make.centerY.equalTo(logoImageView)
//            make.width.equalTo(28)
//            make.height.equalTo(14)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
        }
        
        lockImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
//            make.size.equalTo(80)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(lockImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        payHereUseButton.snp.makeConstraints { make in
            make.bottom.equalTo(okButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        okButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.horizontalEdges.bottom.equalToSuperview().inset(12)
        }
    }
}
