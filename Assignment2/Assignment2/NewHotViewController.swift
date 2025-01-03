//
//  NewHotViewController.swift
//  Assignment2
//
//  Created by 조성민 on 12/27/24.
//

import UIKit

class NewHotViewController: UIViewController {

    @IBOutlet var buttonList: [UIButton]!
    @IBOutlet var centerLabel: UILabel!
    var buttonTitleList: [String] = [
        "공개 예정",
        "모두의 인기 콘텐츠",
        "TOP 10 시리즈"
    ]
    var buttonImageNameList: [String] = [
        "blue",
        "turquoise",
        "pink"
    ]
    var announceTextList: [String] = [
        "이런! 찾으시는 작품이 없습니다.",
        "아이고! 원하는 작품이 없네요.",
        "에헤이! 탐색할 작품이 없어요."
    ]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonListDesign()
        centerLabelDesign()
    }
    
    func buttonListDesign() {
        for idx in 0...2 {
            buttonList[idx].tag = idx
            buttonList[idx].setTitle(buttonTitleList[idx], for: .normal)
            buttonList[idx].titleLabel?.font = .systemFont(ofSize: 12)
            buttonList[idx].setImage(UIImage(named: buttonImageNameList[idx]), for: .normal)
            buttonList[idx].setTitleColor(.white, for: .normal)
            buttonList[idx].backgroundColor = .black
            buttonList[idx].layer.cornerRadius = 14
        }
    }
    
    func centerLabelDesign() {
        centerLabel.textAlignment = .center
        centerLabel.font = .boldSystemFont(ofSize: 26)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        buttonList[selectedIndex].setTitleColor(.white, for: .normal)
        buttonList[selectedIndex].backgroundColor = .black
        selectedIndex = sender.tag
        buttonList[selectedIndex].setTitleColor(.black, for: .normal)
        buttonList[selectedIndex].backgroundColor = .white
        centerLabel.text = announceTextList[sender.tag]
    }
    
}
