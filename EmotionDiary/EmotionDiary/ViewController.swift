//
//  ViewController.swift
//  EmotionDiary
//
//  Created by 조성민 on 12/26/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttonList: [UIButton]!
    @IBOutlet var labelList: [UILabel]!
    @IBOutlet var resetButton: UIButton!
    
    var labelTextList: [String] = [
        "행복해", "사랑해", "좋아해",
        "당황해", "속상해", "우울해",
        "심심해", "무력해", "울적해"
    ]
    var labelCountList: [Int] = [
        0, 0, 0,
        0, 0, 0,
        0, 0, 0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonListDesign()
        resetButtonDesign()
    }
    
    func buttonListDesign() {
        for idx in 0...8 {
            buttonList[idx].setImage(UIImage(named: "mono_slime\(idx+1)"), for: .normal)
            buttonList[idx].tag = idx
            labelList[idx].textAlignment = .center
            labelCountList[idx] = UserDefaults.standard.integer(forKey: "\(idx)")
            labelList[idx].text = labelTextList[idx] + " " + String(labelCountList[idx])
        }
    }

    func resetButtonDesign() {
        resetButton.setTitle("초기화하기", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        labelCountList[sender.tag] += 1
        UserDefaults.standard.setValue(labelCountList[sender.tag], forKey: "\(sender.tag)")
        labelList[sender.tag].text  = labelTextList[sender.tag] + " " + String(labelCountList[sender.tag])
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        for idx in 0...8 {
            labelCountList[idx] = 0
            labelList[idx].text  = labelTextList[idx] + " " + String(labelCountList[idx])
            UserDefaults.standard.removeObject(forKey: "\(idx)")
        }
    }
    
}

