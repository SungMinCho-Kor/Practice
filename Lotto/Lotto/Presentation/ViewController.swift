//
//  ViewController.swift
//  Lotto
//
//  Created by 조성민 on 1/14/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController, ViewConfiguration {
    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()
    
    private let dateFormatter = DateFormatter()
    private let pickerView = UIPickerView()
    private let lottoTextField = UITextField()
    private let announceLabel = UILabel()
    private let dateLabel = UILabel()
    private let dividerView = UIView ()
    private let roundLabel = UILabel()
    private let resultLabel = UILabel()
    private let firstBallLabel = UILabel()
    private let secondBallLabel = UILabel()
    private let thirdBallLabel = UILabel()
    private let fourthBallLabel = UILabel()
    private let fifthBallLabel = UILabel()
    private let sixthBallLabel = UILabel()
    private let plusImageView = UIImageView()
    private let bonusBallLabel = UILabel()
    private let bonusLabel = UILabel()
    private let roundStackView = UIStackView()
    private let ballsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
        bind()
    }
    
    private func bind() {
        let selectedRound = pickerView.rx.modelSelected(Int.self)
            .map { $0[0] }
        
        selectedRound
            .asDriver(onErrorJustReturn: 0)
            .drive(with: self) { owner, round in
                owner.lottoTextField.text = "\(round)"
            }
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(
            input: ViewModel.Input(
                selectRound: selectedRound
            )
        )
        
        output.roundText
            .drive(lottoTextField.rx.text)
            .disposed(by: disposeBag)
        
        output.lottoData
            .drive(with: self) { owner, value in
                owner.dateLabel.text = value.drwNoDate
                owner.firstBallLabel.text = "\(value.drwtNo1)"
                owner.secondBallLabel.text = "\(value.drwtNo2)"
                owner.thirdBallLabel.text = "\(value.drwtNo3)"
                owner.fourthBallLabel.text = "\(value.drwtNo4)"
                owner.fifthBallLabel.text = "\(value.drwtNo5)"
                owner.sixthBallLabel.text = "\(value.drwtNo6)"
                owner.bonusBallLabel.text = "\(value.bnusNo)"
            }
            .disposed(by: disposeBag)
        
        output.pickerItems
            .drive(pickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        output.ballColors
            .drive(with: self) { owner, colors in
                self.firstBallLabel.backgroundColor = colors[0].uiColor
                self.secondBallLabel.backgroundColor = colors[1].uiColor
                self.thirdBallLabel.backgroundColor = colors[2].uiColor
                self.fourthBallLabel.backgroundColor = colors[3].uiColor
                self.fifthBallLabel.backgroundColor = colors[4].uiColor
                self.sixthBallLabel.backgroundColor = colors[5].uiColor
                self.bonusBallLabel.backgroundColor = colors[6].uiColor
            }
            .disposed(by: disposeBag)
    }
    
    func configureHierarchy() {
        [
            lottoTextField,
            announceLabel,
            dateLabel,
            dividerView,
            roundStackView,
            ballsStackView,
            bonusLabel
        ].forEach(view.addSubview)
        [
            roundLabel,
            resultLabel
        ].forEach(roundStackView.addArrangedSubview)
        [
            firstBallLabel,
            secondBallLabel,
            thirdBallLabel,
            fourthBallLabel,
            fifthBallLabel,
            sixthBallLabel,
            plusImageView,
            bonusBallLabel,
        ].forEach(ballsStackView.addArrangedSubview)
    }
    
    func configureLayout() {
        lottoTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
        
        announceLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(lottoTextField.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(announceLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        roundStackView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        [
            firstBallLabel,
            secondBallLabel,
            thirdBallLabel,
            fourthBallLabel,
            fifthBallLabel,
            sixthBallLabel,
            bonusBallLabel
        ].forEach { view in
            view.snp.makeConstraints { make in
                make.size.equalTo(40)
            }
        }
        
        ballsStackView.snp.makeConstraints { make in
            make.top.equalTo(roundStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureView() {
        lottoTextField.borderStyle = .roundedRect
        lottoTextField.textAlignment = .center
        lottoTextField.inputView = pickerView
        
        announceLabel.text = "당첨번호 안내"
        
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .lightGray
        
        dividerView.backgroundColor = .darkGray
        
        roundLabel.textColor = .systemYellow
        roundLabel.font = .systemFont(
            ofSize: 24,
            weight: .bold
        )
        
        resultLabel.font = .systemFont(ofSize: 24)
        resultLabel.text = "당첨결과"
        
        [
            firstBallLabel,
            secondBallLabel,
            thirdBallLabel,
            fourthBallLabel,
            fifthBallLabel,
            sixthBallLabel,
            bonusBallLabel
        ].forEach { ballLabel in
            ballLabel.font = .systemFont(ofSize: 24)
            ballLabel.textColor = .white
            ballLabel.textAlignment = .center
            ballLabel.layer.cornerRadius = 20
            ballLabel.clipsToBounds = true
        }
        
        plusImageView.image = UIImage(systemName: "plus")
        plusImageView.tintColor = .black
        
        ballsStackView.alignment = .center
        ballsStackView.spacing = 4
    }
}
