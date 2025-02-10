//
//  NumberViewModel.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/5/25.
//

import Foundation

final class NumberViewModel {
    
    struct Input {
        // 사용자가 입력한 값 받아오기
        let inputField: Field<String?> = Field(nil)
    }
    
    struct Output {
        let outputText: Field<String> = Field("")
        let outputTextColor = Field(false)
    }
    
    private(set) var input: Input
    var output: Output
    
    init() {
        print("NumberViewModel init")
        input = Input()
        output = Output()
            
        input.inputField.bind { text in
            print("inputField", text)
            self.validation()
        }
    }
    
    func validation() {
        guard let text = input.inputField.value else {
            output.outputText.value = ""
            return
        }
        
        guard !text.isEmpty else {
            output.outputText.value = "값을 입력해주세요."
            output.outputTextColor.value = true
            return
        }
        
        guard let num = Int(text) else {
            output.outputText.value = "숫자만 입력해주세요."
            output.outputTextColor.value = true
            return
        }
        
        guard num >= 0 && num <= 1_000_000 else {
            output.outputText.value = "100만원 이하의 값을 입력해주세요."
            output.outputTextColor.value = true
            return
        }
        
        output.outputText.value = "₩" + num.formatted()
        output.outputTextColor.value = false
    }

}
