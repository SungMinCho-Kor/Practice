//
//  ViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum CustomError: Error {
    case incorrect
}

final class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let nicknameTextField = UITextField()
    private let nextButton = UIButton()
    
    private let publishSubject = PublishSubject<Int>()
    private let behaviorSubject = BehaviorSubject(value: 0)
    
    private let textFieldText = BehaviorRelay(value: "고래밥 \(Int.random(in: 0...10))")
    
    private let quiz = Int.random(in: 0...10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViews()
        customObservableBind()
        print("quiz", quiz)
        randomNumber()
            .bind(with: self) { owner, value in
                print(value)
            }
            .disposed(by: disposeBag)
    }

    private func configureViews() {
        [
            nicknameTextField,
            nextButton
        ].forEach(view.addSubview)
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        nicknameTextField.borderStyle = .roundedRect
        nextButton.setTitle("next", for: .normal)
        nextButton.backgroundColor = .systemBlue
    }
    
    private func customObservableBind() {
        nextButton.rx.tap
            .map { Int.random(in: 0...10) }
            .bind(with: self) { owner, value in
                print(value)
                owner.play(value: value)
            }
            .disposed(by: disposeBag)
    }
    
    private func play(value: Int) {
        randomQuiz(number: value)
            .subscribe(with: self) { owner, value in
                print(value)
            } onError: { owner, error in
                print(#function, "onError", error)
            } onCompleted: { owner in
                print(#function, "onCompleted")
            } onDisposed: { owner in
                print(#function, "onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func randomNumber() -> Observable<Int> {
        return Observable<Int>.create { value in
            value.onNext(Int.random(in: 0...10))
            return Disposables.create()
        }
    }
    
    private func randomQuiz(number: Int) -> Observable<Bool> {
        return Observable<Bool>.create { value in
            if number == self.quiz {
                value.onNext(true)
                value.onCompleted()
            } else {
                value.onNext(false)
                value.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    // subscribe: next, complete, error. 메인 X
    // bind: next. 메인 X
    // drive: 메인 O, 스트림 공유
//    private func bind() {
//        nextButton.rx.tap
//            .map {
//                print("기본이 메인스레인가 : ", Thread.isMainThread)
//            }
//            .observe(on: MainScheduler.instance)
//            .map {
//                print(".observe(on: MainScheduler.instance) 이후에는 (1) : ", Thread.isMainThread)
//            }
//            .map {
//                print(".observe(on: MainScheduler.instance) 이후에는 (2) : ", Thread.isMainThread)
//            }
//            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
//            .map {
//                print(".observe(on: ConcurrentDispatchQueueScheduler(qos: .default)) 이후에는 (1) : ", Thread.isMainThread)
//            }
//            .map {
//                print(".observe(on: ConcurrentDispatchQueueScheduler(qos: .default)) 이후에는 (2) : ", Thread.isMainThread)
//            }
//            .observe(on: MainScheduler.instance)
//            .bind(with: self) { owner, _ in
//                print("스트림 이후에는 : ", Thread.isMainThread)
//            }
//            .disposed(by: disposeBag)
        
//        nextButton.rx.tap
//            .asDriver()
//            .drive(with: self) { owner, _ in
//                print(#function, "drive")
//            }
//            .disposed(by: disposeBag)
//    }

    // 스트림 공유
    // share()를 이용하면 공유가 가능하지만, drive는 share가 없어도 공유가 가능
//    func bind() {
////        let tap = nextButton.rx.tap
////            .map { "안녕하세요 \(Int.random(in: 1...100))" }
////            .share()
////        
////        tap.bind(to: nicknameTextField.rx.text)
////            .disposed(by: disposeBag)
////
////        tap.bind(to: nextButton.rx.title())
////            .disposed(by: disposeBag)
//        
//        let tap = nextButton.rx.tap
//            .map { "안녕하세요 \(Int.random(in: 1...100))" }
//            .asDriver(onErrorJustReturn: "빈문자열이라도 내뱉어줘~")
//        
//        tap
//            .drive(nextButton.rx.title())
//            .disposed(by: disposeBag)
//        
//        tap
//            .drive(navigationItem.rx.title)
//            .disposed(by: disposeBag)
//    }
    
    
    // nicknameTextField.rx.text.orEmpty로 연결해놔도 owner.nicknameTextField.text = "\(value)" 를 감지하짐 못함
//    func bind() {
////        nicknameTextField.rx.text.orEmpty // 구독시 바로 한 번 호출됨, focus 하면 또 실행됨
//        nicknameTextField.rx.text.orEmpty.changed // 구독시 호출 안 됨, focus 하면 실행 됨
//            .subscribe(with: self) { owner, value in
//                print("orEmpty")
//                print(#function, value)
//            } onError: { owner, error in
//                print(#function, "onError", error)
//            } onCompleted: { owner in
//                print(#function, "onCompleted")
//            } onDisposed: { owner in
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
//        
//        // UI 처리에 특화된 Observable은 Trait,
//        // RxCocoa의 Trait은 ControlProperty, ControlEvent, Driver
//        publishSubject
//            .subscribe(with: self) { owner, value in
//                print("publishSubject")
//                print(#function, value)
//                owner.nicknameTextField.text = "\(value)"
//            } onError: { owner, error in
//                print(#function, "onError", error)
//            } onCompleted: { owner in
//                print(#function, "onCompleted")
//            } onDisposed: { owner in
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
//        
//        behaviorSubject // 구독시 바로 한 번 호출됨.
//            .subscribe(with: self) { owner, value in
//                print("behaviorSubject")
//                print(#function, value)
//            } onError: { owner, error in
//                print(#function, "onError", error)
//            } onCompleted: { owner in
//                print(#function, "onCompleted")
//            } onDisposed: { owner in
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
//        
//        nextButton.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.publishSubject.onNext(11)
//                owner.behaviorSubject.onNext(22)
//            }
//            .disposed(by: disposeBag)
//    }
    
//    private func bind() {
//        textFieldText
//            .subscribe(with: self) { owner, value in
//                print("textFieldText.subscribe, value: \(value)")
//                owner.nicknameTextField.text = value
//            } onError: { owner, error in
//                print(#function, "onError", error)
//            } onCompleted: { owner in
//                print(#function, "onCompleted")
//            } onDisposed: { owner in
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
//        
//        nextButton.rx.tap
//            .subscribe(with: self) { owner, _ in
//                let result = owner.textFieldText.value
//                print(result)
//            } onError: { owner, error in
//                print(#function, "onError", error)
//            } onCompleted: { owner in
//                print(#function, "onCompleted")
//            } onDisposed: { owner in
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
//    }
}

