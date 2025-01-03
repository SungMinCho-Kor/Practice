//
//  DateViewController.swift
//  FirstApp
//
//  Created by 조성민 on 12/27/24.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet var buttonList: [UIButton]!
    
    @IBOutlet var emotionLabel: UILabel!
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    let titleList = ["좋아해", "싫어해", "사랑해", "우울해"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 EEEE"
        print(dateFormatter.string(from: datePicker.date))
        print(datePicker.date.formatted())
        
        for idx in 0...3 {
            buttonList[idx].setTitle(titleList[idx], for: .normal)
            buttonList[idx].tag = idx
        }
        
        dateButtonTapped(checkButton)
        resultLabelDesign()
    }
    
    func resultLabelDesign() {
        resultLabel.textAlignment = .center
    }
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        print(datePicker.date)
        resultLabel.text = "\(datePicker.date)로 선택"
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        print(datePicker.date)
        resultLabel.text = "\(datePicker.date)로 선택"
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        print(sender.currentTitle!, "| tag:", sender.tag)
        
        let value = sender.currentTitle!
        emotionLabel.text = value
        if value == "좋아해" {
            emotionLabel.text = "좋아해 라고 클릭했어요"
        } else if value == "싫어해" {
            emotionLabel.text = "서운하대요"
        } else if value == "사랑해" {
            emotionLabel.text = "사랑한대요!!"
        } else if value == "우울해" {
            emotionLabel.text = "우울하대요ㅠㅠ"
        } else {
            print("nothing")
        }
    }
    
}
