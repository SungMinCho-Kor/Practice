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
        view.addSubview(button)
        button.backgroundColor = .red
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        view.backgroundColor = .lightGray
        navigationItem.title = "Detail"
        
        
        button
            .rx
            .tap
            .map { _ in UIColor.blue }
//            .bind(to: view.rx.backgroundColor)
            .bind { color in
                self
            }
//            .bind { [weak self] color in
//                self?.view.backgroundColor = color
//            }
            .disposed(by: disposeBag)
        
//        backgroundColorObservable1
//            .bind(to: view.rx.backgroundColor)
//            .disposed(by: disposeBag)
//        backgroundColorObservable2
//            .bind(onNext: { color in
//                self.view.backgroundColor = color
//            })
//            .disposed(by: disposeBag)
    }
    
    deinit {
        print(#function, self)
    }
    
}
