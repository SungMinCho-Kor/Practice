//
//  CurrencyViewModel.swift
//  Assignment250205
//
//  Created by 조성민 on 2/5/25.
//

final class CurrencyViewModel {
    let exchangeRate: Double = 1445.30
    let outputResultText: Observable<String?> = Observable("환전 결과가 여기에 표시됩니다")
    let inputAmountText: Observable<String?> = Observable(nil)
    
    init() {
        inputAmountText.lazyBind { _ in
            self.validate()
        }
    }
    
    private func validate() {
        guard let amountText = inputAmountText.value,
              let amount = Double(amountText) else {
            outputResultText.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let convertedAmount = amount / exchangeRate
        outputResultText.value = String(
            format: "%.2f USD (약 $%.2f)",
            convertedAmount,
            convertedAmount
        )
    }
    
}
