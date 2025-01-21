//
//  ViewController.swift
//  FiveWeek
//
//  Created by 조성민 on 1/20/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let checkButton = {
        let view = UIButton()
        view.backgroundColor = .red
        return view
    }()
    
    let firstImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        return view
    }()
    let secondImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        return view
    }()
    let thirdImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        //        serialSync()
        //        serialAsync()
        //        concurrentSync()
        //        concurrentAsync()
        example2()
    }
    
    func example() {
        print("start")
        DispatchQueue.global().async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        for i in 101...200 {
            print(i, terminator: " ")
        }
        for i in 201...300 {
            print(i, terminator: " ")
        }
    }
    
    // DispatchGroup
    func example2() {
        let group = DispatchGroup()
        print("start")
        group.enter()
        DispatchQueue.global().async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
            group.leave()
        }
        group.notify(queue: .main) {
            print("신호 끝!")
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            print(#function)
        }
    }
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        DispatchQueue.main.async {
            print(#function)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            print(#function)
        }
    }
    
    func configureView() {
        view.addSubview(firstImageView)
        view.addSubview(checkButton)
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
        
        checkButton.addTarget(
            self,
            action: #selector(checkButtonTappp),
            for: .touchUpInside
        )
        
        firstImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        secondImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(firstImageView)
            make.top.equalTo(firstImageView.snp.bottom).offset(20)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(secondImageView)
            make.top.equalTo(secondImageView.snp.bottom).offset(20)
        }
        
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func checkButtonTappp(_ sender: UIButton) {
        // 장점 : 빠르게 작업이 끝날 수 있다.
        // 단점 : 여러 작업이 모두 종료되었다는 신호를 받기가 어렵다.
        print(#function, "Start")
        let group = DispatchGroup()
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.fetchImage { image in
                print("firstImageView 성공")
                self.firstImageView.image = image
            }
        }
        
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.fetchImage { image in
                print("secondImageView 성공")
                self.secondImageView.image = image
            }
        }
        DispatchQueue.global().async(group: group) {
            NetworkManager.shared.fetchImage { image in
                print("thirdImageView 성공")
                self.thirdImageView.image = image
            }
        }
        print(#function, "End")
        
        //        // 단점 보완 -> 종료 타이밍 알기 -> but 오래걸림 -> DispatchGroup의 등장
        //        // 위와 아래의 차이를 알아보기
        //        print(#function, "Start")
        //        NetworkManager.shared.fetchImage { image in
        //            print("firstImageView 성공")
        //            self.firstImageView.image = image
        //            NetworkManager.shared.fetchImage { image in
        //                print("secondImageView 성공")
        //                self.secondImageView.image = image
        //                NetworkManager.shared.fetchImage { image in
        //                    print("thirdImageView 성공")
        //                    self.thirdImageView.image = image
        //                    print("여기가 이미지 받기 마지막")
        //                }
        //            }
        //        }
        //        print(#function, "End")
    }
}

extension ViewController {
    func serialSync() {
        print("Start", terminator: " ")
        for item in 1...100 {
            print(item, terminator: " ")
        }
        //        DispatchQueue.main.sync {
        //            for item in 101...200 {
        //                print(item, terminator: " ")
        //            }
        //        }
        print("End", terminator: " ")
    }
    func serialAsync() {
        print("Start", terminator: " ")
        DispatchQueue.main.async {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        for item in 101...200 {
            print(item, terminator: " ")
        }
        print("End", terminator: " ")
    }
    func concurrentSync() {
        print("Start", terminator: " ")
        DispatchQueue.global().sync {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        for item in 101...200 {
            print(item, terminator: " ")
        }
        print("End", terminator: " ")
    }
    func concurrentAsync() {
        print("Start", terminator: " ")
        DispatchQueue.global().async {
            for item in 1...100 {
                print(item, terminator: " ")
            }
        }
        for item in 101...200 {
            print(item, terminator: " ")
        }
        print("End", terminator: " ")
    }
    
}
