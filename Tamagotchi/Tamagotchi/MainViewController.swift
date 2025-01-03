//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 조성민 on 1/2/25.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var editNicknameButton: UIBarButtonItem!
    @IBOutlet var messageImageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var statusTitleLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var feedTextField: UITextField!
    @IBOutlet var feedTextFieldBottomView: UIView!
    @IBOutlet var feedButton: UIButton!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var waterTextFieldBottomView: UIView!
    @IBOutlet var waterButton: UIButton!
    
    var nickname: String = "대장"
    var feed: Int = 0
    var water: Int = 0
    var level: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setStatus()
        viewDesign()
        navigationDesign()
        messageImageViewDesign()
        messageLabelDesign()
        tamagotchiImageViewDesign()
        statusTitleLabelDesign()
        statusLabelDesign()
        feedTextFieldDesign()
        feedTextFieldBottomViewDesign()
        feedButtonDesign()
        waterTextFieldDesign()
        waterTextFieldBottomViewDesign()
        waterButtonDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nickname = UserDefaults.standard.string(forKey: "nickname") ?? "대장"
        navigationItem.title = "\(nickname)님의 다마고치"
        messageLabel.text = randomString(action: .none)
    }
    
    // navigtaionItem.title에 보간법이 들어가면 back button에 자동으로 기입되지 않는다는 사실을 알게되었습니다!!
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = "다마고치"
    }
    
    func setStatus() {
        nickname = UserDefaults.standard.string(forKey: "nickname") ?? "대장"
        feed = UserDefaults.standard.integer(forKey: "feed")
        water = UserDefaults.standard.integer(forKey: "water")
        
        let tmpLevel = Int((Double(feed)/5.0 + Double(water)/2.0)/10.0)
        if tmpLevel <= 1 {
            level = 1
        } else if tmpLevel >= 10 {
            level = 10
        } else {
            level = tmpLevel
        }
    }
    
    func viewDesign() {
        view.backgroundColor = .tamagotchiBackground
    }
    
    func navigationDesign() {
        editNicknameButton.image = UIImage(systemName: "person.circle")
        editNicknameButton.tintColor = .tamagotchiPrimary
    }
    
    func messageImageViewDesign() {
        messageImageView.image = .bubble
    }
    
    func messageLabelDesign() {
        messageLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = .tamagotchiPrimary
    }
    
    func tamagotchiImageViewDesign() {
        tamagotchiImageView.image = UIImage(named: "2-\(level >= 10 ? 9 : level)")
    }
    
    func statusTitleLabelDesign() {
        statusTitleLabel.text = "방실방실 다마고치"
        statusTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        statusTitleLabel.textAlignment = .center
        statusTitleLabel.textColor = .tamagotchiPrimary
        statusTitleLabel.layer.borderWidth = 0.5
        statusTitleLabel.layer.borderColor = UIColor.tamagotchiPrimary.cgColor
        statusTitleLabel.layer.cornerRadius = 4
        statusTitleLabel.backgroundColor = .tamagotchiSubBackground
    }
    
    func statusLabelDesign() {
        statusLabel.textColor = .tamagotchiPrimary
        statusLabel.font = .boldSystemFont(ofSize: 14)
        statusLabel.text = "LV\(level) · 밥알 \(feed)개 · 물방울 \(water)개"
    }
    
    func feedTextFieldDesign() {
        feedTextField.borderStyle = .none
        feedTextField.textAlignment = .center
        feedTextField.placeholder = "밥주세용"
        feedTextField.keyboardType = .numberPad
    }
    
    func feedTextFieldBottomViewDesign() {
        feedTextFieldBottomView.backgroundColor = .tamagotchiPrimary
    }
    
    func feedButtonDesign() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "밥먹기"
        configuration.baseForegroundColor = .tamagotchiPrimary
        configuration.image = UIImage(systemName: "drop.circle")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 4
        feedButton.configuration = configuration
        
        feedButton.layer.cornerRadius = 10
        feedButton.layer.borderWidth = 1
        feedButton.layer.borderColor = UIColor.tamagotchiPrimary.cgColor
    }
    
    func waterTextFieldDesign() {
        waterTextField.borderStyle = .none
        waterTextField.textAlignment = .center
        waterTextField.placeholder = "물주세용"
        waterTextField.keyboardType = .numberPad
    }
    
    func waterTextFieldBottomViewDesign() {
        waterTextFieldBottomView.backgroundColor = .tamagotchiPrimary
    }
    
    func waterButtonDesign() {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "물먹기"
        configuration.baseForegroundColor = .tamagotchiPrimary
        configuration.image = UIImage(systemName: "leaf.circle")
        configuration.imagePlacement = .leading
        configuration.imagePadding = 4
        waterButton.configuration = configuration
        
        waterButton.layer.cornerRadius = 10
        waterButton.layer.borderWidth = 1
        waterButton.layer.borderColor = UIColor.tamagotchiPrimary.cgColor
    }
    
    @IBAction func feedButtonTapped(_ sender: UIButton) {
        if feedTextField.text?.isEmpty == true {
            feed += 1
            updateStatus(.feed)
            UserDefaults.standard.setValue(feed, forKey: "feed")
        } else if let inputFeed = Int(feedTextField.text!),
                  inputFeed < 100 {
            feed += inputFeed
            updateStatus(.feed)
            UserDefaults.standard.setValue(feed, forKey: "feed")
        } else {
            let alert = UIAlertController(
                title: "밥먹기 경고",
                message: "99개까지 먹을 수 있어요",
                preferredStyle: .alert
            )
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
        feedTextField.text = ""
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        if waterTextField.text?.isEmpty == true {
            water += 1
            updateStatus(.water)
            UserDefaults.standard.setValue(water, forKey: "water")
        } else if let inputWater = Int(waterTextField.text!),
                  inputWater < 50 {
            water += inputWater
            updateStatus(.water)
            UserDefaults.standard.setValue(water, forKey: "water")
        } else {
            let alert = UIAlertController(
                title: "물먹기 경고",
                message: "49개까지 먹을 수 있어요",
                preferredStyle: .alert
            )
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
        }
        waterTextField.text = ""
    }
    
    func updateStatus(_ action: Action) {
        var message: String?
        switch action {
        case .feed:
            message = randomString(action: .feed)
        case .water:
            message = randomString(action: .water)
        default:
            message = randomString(action: .none)
        }
        
        var tmpLevel = Int((Double(feed)/5.0 + Double(water)/2.0)/10.0)
        if tmpLevel <= 1 {
            tmpLevel = 1
        } else if tmpLevel >= 10 {
            tmpLevel = 10
        }
        if level != tmpLevel {
            level = tmpLevel
            message = randomString(action: .level)
            tamagotchiImageView.image = UIImage(named: "2-\(level >= 10 ? 9 : level)")
        }
        
        statusLabel.text = "LV\(level) · 밥알 \(feed)개 · 물방울 \(water)개"
        messageLabel.text = message
        view.endEditing(true)
    }
    
    @IBAction func viewTapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func randomString(action: Action) -> String? {
        switch action {
        case .none:
            return [
                "\(nickname)님, 안녕하세요.",
                "반갑습니다 \(nickname)님",
                "하이 하이 \(nickname)님 반가워요"
            ].randomElement()
        case .water:
            return [
                "물이다 물~",
                "\(nickname)님 물 주셔서 감사합니다",
                "목 말랐는데 감사해요 \(nickname)님"
            ].randomElement()
        case .feed:
            return [
                "밥 줘서 고마워요 \(nickname)님",
                "\(nickname)님! 밥 맛있게 먹었어요",
                "\(nickname)님, 밥 먹었더니 힘이 나요"
            ].randomElement()
        case .level:
            return [
                "레벨업 했어요 \(nickname)님",
                "밥과 물을 잘먹었더니 레벨업 했어요 고마워요 \(nickname)님"
            ].randomElement()
        }
    }
    
}

enum Action {
    case none
    case feed
    case water
    case level
}
