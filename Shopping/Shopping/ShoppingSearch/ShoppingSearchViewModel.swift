//
//  ShoppingSearchViewModel.swift
//  Shopping
//
//  Created by 조성민 on 2/6/25.
//

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class ShoppingSearchViewModel: ViewModel {
    struct Input {
        let searchButtonClicked: Observable<String?>
    }
    
    struct Output {
        let presentAlert: Observable<Void> = Observable(())
        let pushDetailViewController: Observable<String> = Observable("")
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        input.searchButtonClicked.bind { text in
            guard let searchText = text?.trimmingCharacters(in: .whitespacesAndNewlines), searchText.count >= 2 else {
                output.presentAlert.value = ()
                return
            }
            output.pushDetailViewController.value = searchText
        }
        
        return output
    }
}
