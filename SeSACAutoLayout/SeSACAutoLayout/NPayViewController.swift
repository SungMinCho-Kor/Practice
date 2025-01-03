//
//  NPayViewController.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 12/31/24.
//

import UIKit

class NPayViewController: UIViewController {
    
    @IBOutlet var segmentContainerView: UIView!
    @IBOutlet var segmentButtonList: [UIButton]!
    @IBOutlet var segmentStackView: UIStackView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var logoImageView: UIImageView!
    @IBOutlet var typePullDownButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var centerImageView: UIImageView!
    @IBOutlet var centerLabel: UILabel!
    @IBOutlet var payNowCheckButton: UIButton!
    @IBOutlet var payNowLabel: UILabel!
    @IBOutlet var okButton: UIButton!
    
    var segmentButtonTitleList: [String] = [
        "멤버십",
        "현장결제",
        "쿠폰"
    ]
    var selectedSegmentIndex: Int = 1
    var isPayNow = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        segmentContainerViewDesign()
        segmentButtonListDesign()
        segmentStackViewDesign()
        containerViewDesign()
        logoImageViewDesign()
        typePullDownButtonDesign()
        closeButtonDesign()
        centerImageViewDesign()
        centerLabelDesign()
        payNowCheckButtonDesign()
        payNowLabelDesign()
        okButtonDesign()
    }
    
    func segmentContainerViewDesign() {
        segmentContainerView.backgroundColor = .black
        segmentContainerView.layer.cornerRadius = 23
    }
    
    func segmentButtonListDesign() {
        for idx in 0...2 {
            segmentButtonList[idx].setTitle(segmentButtonTitleList[idx], for: .normal)
            segmentButtonList[idx].backgroundColor = .black
            segmentButtonList[idx].setTitleColor(.white, for: .normal)
            segmentButtonList[idx].setTitleColor(.white, for: .highlighted)
            segmentButtonList[idx].layer.cornerRadius = 18
            segmentButtonList[idx].tag = idx
        }
        segmentButtonTapped(segmentButtonList[selectedSegmentIndex])
    }
    
    func segmentStackViewDesign() {
        segmentStackView.alignment = .center
        segmentStackView.spacing = 5
        segmentStackView.distribution = .fillEqually
    }
    
    func containerViewDesign() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
    }
    
    func logoImageViewDesign() {
        logoImageView.image = .npay
    }
    
    func typePullDownButtonDesign() {
        var attributedString = AttributedString("국내")
        attributedString.font = .systemFont(ofSize: 12)
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.attributedTitle = attributedString
        buttonConfiguration.image = UIImage(
            systemName: "arrowtriangle.down.fill"
        )?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 6))
        buttonConfiguration.baseForegroundColor = .gray
        buttonConfiguration.imagePlacement = .trailing
        buttonConfiguration.contentInsets = .zero
        typePullDownButton.configuration = buttonConfiguration
    }
    
    func closeButtonDesign() {
        closeButton.setImage(
            UIImage(systemName: "xmark"),
            for: .normal
        )
        closeButton.tintColor = .black
        closeButton.setTitle("", for: .normal)
    }
    
    func centerImageViewDesign() {
        centerImageView.image = .lock
    }
    
    func centerLabelDesign() {
        centerLabel.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        centerLabel.textAlignment = .center
        centerLabel.numberOfLines = 2
        centerLabel.font = .boldSystemFont(ofSize: 20)
        centerLabel.textColor = .black
    }
    
    func payNowCheckButtonDesign() {
        payNowCheckButton.setImage(
            UIImage(systemName: "checkmark.circle.fill"),
            for: .normal
        )
        payNowCheckButton.tintColor = .systemGreen
    }
    
    func payNowLabelDesign() {
        payNowLabel.text = "바로결제 사용하기"
        payNowLabel.textColor = .black
        payNowLabel.font = .systemFont(ofSize: 16)
    }
    
    func okButtonDesign() {
        okButton.backgroundColor = .systemGreen
        okButton.layer.cornerRadius = 24
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func segmentButtonTapped(_ sender: UIButton) {
        segmentButtonList[selectedSegmentIndex].backgroundColor = .black
        selectedSegmentIndex = sender.tag
        segmentButtonList[selectedSegmentIndex].backgroundColor = .darkGray
    }
    
    @IBAction func payNowButtonTapped(_ sender: UIButton) {
        isPayNow.toggle()
        sender.setImage(
            UIImage(systemName: isPayNow ? "checkmark.circle.fill" : "checkmark.circle"),
            for: .normal
        )
    }
    
}

