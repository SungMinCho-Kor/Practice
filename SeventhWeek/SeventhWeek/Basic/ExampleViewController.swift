//
//  ExampleViewController.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/4/25.
//

import UIKit

class User<T> {
    private var closure: (() -> Void)?
    
    var value: T {
        didSet {
            closure?()
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (() -> Void)) {
        self.closure = closure
    }
}

final class ExampleViewController: UIViewController {
    
    private let jack = User(2)
    
    private var nickname = "고래밥" {
        didSet {
            print("닉네임: \(nickname)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jack.value = 3
        jack.value = 4
        jack.value = 5
        
        nickname = "칙촉"
        nickname = "고구마"
        
        configureViews()
        test()
        print("=========")
        test2()
    }
    
    private func test() {
        var num = 3
        print(num)
        num = 6
        num = 4
    }
    
    private func test2() {
        var num = Observable(3)
        num.bind { newNum in
            print(newNum)
        }
        num.value = 6
        num.value = 100
    }
    
    private func configureViews() {
        view.backgroundColor = .white
    }
}
