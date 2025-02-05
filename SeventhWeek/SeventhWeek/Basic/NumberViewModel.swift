//
//  NumberViewModel.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/5/25.
//

import Foundation

final class NumberViewModel {
    // 사용자가 입력한 값 받아오기
    let inputField: Field<String?> = Field(nil)
    
    let outputText: Field<String> = Field("")
    let outputTextColor = Field(false)
    
    init() {
        print("NumberViewModel init")
        inputField.bind { text in
            print("inputField", text)
            self.validation()
        }
    }
    
    func validation() {
        guard let text = inputField.value else {
            outputText.value = ""
            return
        }
        
        guard !text.isEmpty else {
            outputText.value = "값을 입력해주세요."
            outputTextColor.value = true
            return
        }
        
        guard let num = Int(text) else {
            outputText.value = "숫자만 입력해주세요."
            outputTextColor.value = true
            return
        }
        
        guard num >= 0 && num <= 1_000_000 else {
            outputText.value = "100만원 이하의 값을 입력해주세요."
            outputTextColor.value = true
            return
        }
        
        outputText.value = "₩" + num.formatted()
        outputTextColor.value = false
    }

}
