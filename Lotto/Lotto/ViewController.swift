//
//  ViewController.swift
//  Lotto
//
//  Created by 조성민 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

final class ViewController: UIViewController, ViewConfiguration {
    private let dateFormatter = DateFormatter()
    private var maxRound: Int = 1
    
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
        maxRound = calculateLastSaturdayIteration()
    }
    
    func calculateLastSaturdayIteration() -> Int {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let firstRoundDate = dateFormatter.date(from: "2002-12-07") else {
            return 1
        }
        return Int(-firstRoundDate.timeIntervalSinceNow) / 7 / 60 / 60 / 24 + 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
        fetchLottoDate(round: maxRound)
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
        lottoTextField.text = "\(maxRound)"
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(
            0,
            inComponent: 0,
            animated: false
        )
        
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

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return maxRound
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return "\(maxRound - row)"
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        lottoTextField.text = "\(maxRound - row)"
        fetchLottoDate(round: maxRound - row)
    }
    
    private func getBallColor(number: Int) -> UIColor {
        switch number {
        case ...10:
            return .systemYellow
        case ...20:
            return .systemBlue
        case ...30:
            return .systemRed
        case ...40:
            return .gray
        default:
            return .systemGreen
        }
    }
    
    private func fetchLottoDate(round: Int) {
        roundLabel.text = "\(round)회"
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
        AF.request(url, method: .get)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    self.dateLabel.text = value.drwNoDate
                    self.firstBallLabel.text = "\(value.drwtNo1)"
                    self.secondBallLabel.text = "\(value.drwtNo2)"
                    self.thirdBallLabel.text = "\(value.drwtNo3)"
                    self.fourthBallLabel.text = "\(value.drwtNo4)"
                    self.fifthBallLabel.text = "\(value.drwtNo5)"
                    self.sixthBallLabel.text = "\(value.drwtNo6)"
                    self.bonusBallLabel.text = "\(value.bnusNo)"
                    
                    self.firstBallLabel.backgroundColor = self.getBallColor(number: value.drwtNo1)
                    self.secondBallLabel.backgroundColor = self.getBallColor(number: value.drwtNo2)
                    self.thirdBallLabel.backgroundColor = self.getBallColor(number: value.drwtNo3)
                    self.fourthBallLabel.backgroundColor = self.getBallColor(number: value.drwtNo4)
                    self.fifthBallLabel.backgroundColor = self.getBallColor(number: value.drwtNo5)
                    self.sixthBallLabel.backgroundColor = self.getBallColor(number: value.drwtNo6)
                    self.bonusBallLabel.backgroundColor = self.getBallColor(number: value.bnusNo)
                case .failure(let error):
                    dump(error)
                }
            }
    }
}
