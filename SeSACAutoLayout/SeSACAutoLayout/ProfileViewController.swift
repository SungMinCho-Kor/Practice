//
//  ProfileViewController.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 1/1/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var backgroundDimView: UIView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var menuStackView: UIStackView!
    @IBOutlet var giftButton: UIButton!
    @IBOutlet var sendMoneyButton: UIButton!
    @IBOutlet var settingButton: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusMessageLabel: UILabel!
    @IBOutlet var dividerView: UIView!
    @IBOutlet var bottomMenuStackView: UIStackView!
    @IBOutlet var chatWithMeButton: UIButton!
    @IBOutlet var editProfileButton: UIButton!
    @IBOutlet var kakaoStoryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundImageViewDesign()
        backgroundDimViewDesign()
        closeButtonDesign()
        menuStackViewDesign()
        giftButtonDesign()
        sendMoneyButtonDesign()
        settingButtonDesign()
        profileImageViewDesign()
        nameLabelDesign()
        statusMessageLabelDesign()
        dividerViewDesign()
        bottomMenuStackViewDesign()
        chatWithMeButtonDesign()
        editProfileButtonDesign()
        kakaoStoryButtonDesign()
    }
    
    func backgroundImageViewDesign() {
        backgroundImageView.image = .profileBackground
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    func backgroundDimViewDesign() {
        backgroundDimView.backgroundColor = .black
        backgroundDimView.alpha = 0.3
    }
    
    func closeButtonDesign() {
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .lightGray
    }
    
    func menuStackViewDesign() {
        menuStackView.spacing = 4
    }
    
    func giftButtonDesign() {
        giftButton.setImage(
            UIImage(systemName: "gift.circle"),
            for: .normal
        )
        giftButton.tintColor = .lightGray
    }
    
    func sendMoneyButtonDesign() {
        sendMoneyButton.setImage(
            UIImage(systemName: "paperplane.circle"),
            for: .normal
        )
        sendMoneyButton.tintColor = .lightGray
    }
    
    func settingButtonDesign() {
        settingButton.setImage(
            UIImage(systemName: "gear.circle"),
            for: .normal
        )
        settingButton.tintColor = .lightGray
    }
    
    func profileImageViewDesign() {
        profileImageView.image = .profile
        profileImageView.layer.cornerRadius = 32
    }
    
    func nameLabelDesign() {
        nameLabel.text = "조성민"
        nameLabel.textAlignment = .center
        nameLabel.font = .boldSystemFont(ofSize: 18)
    }
    
    func statusMessageLabelDesign() {
        statusMessageLabel.text = "나는 할 수 있다. 나는 할 수 있다. 나는 할 수 있다. 나는 할 수 있다. 나는 할 수 있다. 나는 할 수 있다."
        statusMessageLabel.font = .systemFont(ofSize: 12)
        statusMessageLabel.textAlignment = .center
        statusMessageLabel.numberOfLines = 2
    }
    
    func dividerViewDesign() {
        dividerView.backgroundColor = .lightGray
        dividerView.alpha = 0.5
    }
    
    func bottomMenuStackViewDesign() {
        bottomMenuStackView.spacing = 12
    }
    
    func chatWithMeButtonDesign() {
        chatWithMeButton.configuration = bottomButtonConfiguration(
            title: "나와의 채팅",
            image: UIImage(systemName: "message.fill")
        )
    }
    
    func editProfileButtonDesign() {
        editProfileButton.configuration = bottomButtonConfiguration(
            title: "프로필 편집",
            image: UIImage(systemName: "pencil")
        )
    }
    
    func kakaoStoryButtonDesign() {
        kakaoStoryButton.configuration = bottomButtonConfiguration(
            title: "카카오스토리",
            image: UIImage(systemName: "trophy.fill")
        )
    }
    
    func bottomButtonConfiguration(title: String, image: UIImage?) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        var attributedString = AttributedString(title)
        attributedString.font = .systemFont(ofSize: 12)
        configuration.attributedTitle = attributedString
        configuration.image = image?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 12))
        configuration.imagePlacement = .top
        configuration.imagePadding = 12
        configuration.baseForegroundColor = .white
        return configuration
    }
    
}
