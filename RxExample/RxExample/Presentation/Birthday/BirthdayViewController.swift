//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class BirthdayViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    private let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10 
        return stack
    }()
    
    private let yearLabel: UILabel = {
       let label = UILabel()
        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    private let monthLabel: UILabel = {
       let label = UILabel()
        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    private let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
  
    private let nextButton = PointButton(title: "가입하기")
    
    private let year = BehaviorSubject(value: 2023)
    private let month = BehaviorSubject(value: 33)
    private let day = BehaviorSubject(value: 99)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
    }
    
    private func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func bind() {
        birthDayPicker
            .rx
            .date
            .map { date in
                let calendar = Calendar.current
                let year = Int(calendar.component(.year, from: date))
                let month = Int(calendar.component(.month, from: date))
                let day = Int(calendar.component(.day, from: date))
                return (year, month, day)
            }
            .bind(with: self) { owner, value in
                owner.year.onNext(value.0)
                owner.month.onNext(value.1)
                owner.day.onNext(value.2)
            }
            .disposed(by: disposeBag)
        
        year
            .map { "\($0)년" }
            .bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        Observable.zip(year, month, day)
            .withUnretained(self)
            .map { owner, value in
                let calendar = Calendar.current
                let year = Int(calendar.component(.year, from: Date()))
                let month = Int(calendar.component(.month, from: Date()))
                let day = Int(calendar.component(.day, from: Date()))
                
                if year - value.0 > 17 {
                    return true
                } else if year - value.0 == 17 {
                    if value.1 < month {
                        return true
                    } else if value.1 == month , value.2 <= day {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            }
            .bind(with: self) { owner, value in
                owner.infoLabel.isHidden = value
                owner.nextButton.isEnabled = value
            }
            .disposed(by: disposeBag)
        
        month
            .map { "\($0)월" }
            .bind(to: monthLabel.rx.text)
            .disposed(by: disposeBag)
        
        day
            .map { "\($0)일" }
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        nextButton
            .rx
            .tap
            .bind(with: self) { owner, _ in
                print("aAA")
            }
            .disposed(by: disposeBag)
    }
}
