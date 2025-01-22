//
//  SearchViewController.swift
//  FiveWeek
//
//  Created by 조성민 on 1/22/25.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    let textField = UITextField()
    
    func example() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.width.equalTo(300)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        textField.becomeFirstResponder()
        textField.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
