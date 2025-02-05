//
//  LoginViewModel.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/5/25.
//

final class LoginViewModel {
    
    let inputID: Field<String?> = Field(nil)
    let inputPassword: Field<String?> = Field(nil)
    
    let outputValidText = Field("")
    let outputValidButton = Field(false)
    
    init() {
        inputID.lazyBind { text in
            self.validate()
        }
        
        inputPassword.lazyBind { text in
            self.validate()
        }
    }
    
    private func validate() {
        guard let id = inputID.value,
              let pw = inputPassword.value else {
            outputValidText.value = "nil!!"
            outputValidButton.value = false
            return
        }
        
        if id.count >= 4 && pw.count >= 4 {
            outputValidText.value = "잘 했어요"
            outputValidButton.value = true
        } else {
            outputValidText.value = "아이디, 비밀번호는 4자리 이상입니다."
            outputValidButton.value = false
        }
    }
    
}
