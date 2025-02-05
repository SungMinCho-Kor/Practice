//
//  WordCounterViewModel.swift
//  Assignment250205
//
//  Created by 조성민 on 2/5/25.
//

final class WordCounterViewModel {
    let inputText: Observable<String> = Observable("")
    let outputCount = Observable(0)
    
    init() {
        inputText.lazyBind { _ in
            self.getCount()
        }
    }
    
    func getCount() {
        self.outputCount.value = inputText.value.count
    }
}
