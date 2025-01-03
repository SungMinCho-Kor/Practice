//
//  ViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 12/30/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var wordTextFiled: UITextField!
    @IBOutlet var recommendButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordTextFiled.placeholder = "입력하세요"
        resultLabel.isUserInteractionEnabled = true
        
        wordTextFiled.text = UserDefaults.standard.string(forKey: "number")
        
        dateLabel.text = getToday()
    }
    
    func getToday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        let today = formatter.string(from: Date())
        return today
    }

    @IBAction func textFiedlReturnTapped(_ sender: UITextField) {
        
        let text = wordTextFiled.text!
        
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            resultLabel.text = "검색어를 입력해주세요"
        } else {
            resultLabel.text = "\(text)로 입력했어요"
        }
    }
    
    @IBAction func labelTapped(_ sender: UITapGestureRecognizer) {
        print(#function)
    }
    
    func aboutOptional() {
        var nickname: String? = "조성민"
        var age: Int? = 27
        
        
        if let nickname {
            
        } else {
            
        }
        
        guard let age else {
            print("age 옵셔널 nil")
        }
        
        print(age)
    }
    
    @IBAction func wordTextFieldChanged(_ sender: Any) {
        if let word = Int(wordTextFiled.text!) {
            resultLabel.text = "\(word)"
        } else {
            resultLabel.text = "숫자가 아닙니다."
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        // 1. 타이틀 + 메시지
        
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        // 2. 버튼
        
        let ok = UIAlertAction(
            title: "확인",
            style: .default
        )
        let cancel = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        
        // 3. 본문에 버튼 추가
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        // 4. 화면에 띄우기
        present(alertController, animated: true)
    }
    
}

