//
//  DetailViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 8/1/24.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationItem.title = "Detail"
        view.addSubview(button)
        button.backgroundColor = .black
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        let tap = button.rx.tap
            .map { Int.random(in: 1...100) }
            .share()
        tap
            .bind(with: self) { owner, value in
                print("1번", value)
            }
            .disposed(by: disposeBag)
        
        tap
            .bind(with: self) { owner, value in
                print("2번", value)
            }
            .disposed(by: disposeBag)
        
        tap
            .bind(with: self) { owner, value in
                print("3번", value)
            }
            .disposed(by: disposeBag)
    }
    
    deinit {
        print(#function, self)
    }
    
}
