//
//  ViewController.swift
//  Neologism
//
//  Created by 조성민 on 12/30/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var textFieldContainerView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var recommendButtonStackView: UIStackView!
    @IBOutlet var recommendButtonList: [UIButton]!
    @IBOutlet var iconImageView: UIImageView!
    
    var neologismDictionary: [String: String] = [
        "무야호": "예능 프로그램 <무한도전>에 출연했던 한 출연자에 의해 생겨난 유행어로, 매우 신난다는 뜻.",
        "나심비": "'나'와 '심리' 그리고 '가성비'의 합성어. 가성비보다 스스로의 만족을 위해 지갑을 여는 소비 심리를 일컫는다.",
        "군싹": "'군침이 싹 돌다'의 줄임말. 군침이 돌 만큼 맛있거나 좋아 보이는 것을 수식할 때 쓴다.",
        "얼죽아": "'얼어 죽어도 아이스커피'의 줄임말. 추운 날씨에도 아이스 아메리카노만 마시는 이들을 지칭한다.",
        "스불재": "'스스로 불러온 재앙'으로, 순전히 자신이 자초한 일로 다른 누구를 탓할 수 없는 상황에 쓰는 말.",
        "삼귀다": "아직 사귀는 사이가 아닌 썸 타는 단계. 사귀다의 '사'를 숫자 4에 빗대어 4가 되기 전 3=삼으로 표현.",
        "머선129": "경상도 사투리로 '이게 무슨 일이고?'를 비슷한 발음의 숫자 129로 표현. 영문을 모르는 일이나 황당한 일을 겪을 때 쓴다.",
        "억텐": "'억지 텐션'의 줄임말로 억지로 재미있는 척 격한 반응을 보일 때 쓰인다.",
        "찐텐": "'진짜 텐션'을 뜻하며 실제 신이 난 반응을 뜻한다.",
        "고답이": "고구마 잔뜩 먹은 것처럼 답답하게 행동하는 사람을 일컫는 말.",
        "내또출": "'내일 또 출근'의 줄임말. 월요일 출근에 대한 스트레스를 표현한다.",
        "국룰": "'국민 룰'의 줄임말로 보편적으로 통용되는 정해진 규칙을 말한다.",
        "꾸안꾸": "'꾸민 듯 안 꾸민 듯' 내추럴하지만 스타일리시한 패션 센스를 이르는 말.",
        "마상": "'마음의 상처'를 줄인 말. 아쉽거나 실망스러운 일이 있을 때 주로 쓴다.",
        "낄끼빠빠": "'낄 때 끼고 빠질 때 빠지자'로 나설 상황이 아닌데 눈치 없이 오지랖을 부리는 사람에게 쓰는 표현.",
        "슬세권": "슬리퍼처럼 편한 복장으로 나다닐 수 있는 범위의 생활권역을 지칭.",
        "복세편살": "'복잡한 세상 편하게 살자'의 준말. 스스로가 원하는 방식으로 즐겁게 살겠다는 의지를 다지는 말.",
        "JMT": "어떤 음식이 매우 맛있음을 말한다."
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        textFieldContainerViewDesign()
        searchTextFieldDesign()
        searchButtonDesign()
        resultLabelDesign()
        recommendButtonStackViewDesign()
        recommendButtonListDesign()
        iconImageViewDesign()
    }
    
    func viewDesign() {
        view.backgroundColor = .white
    }
    
    func textFieldContainerViewDesign(){
        textFieldContainerView.backgroundColor = .white
        textFieldContainerView.layer.borderColor = UIColor.black.cgColor
        textFieldContainerView.layer.borderWidth = 1
    }
    
    func searchTextFieldDesign() {
        searchTextField.placeholder = "신조어를 입력하세요"
        searchTextField.backgroundColor = .white
        searchTextField.textColor = .black
        searchTextField.borderStyle = .none
    }
    
    func searchButtonDesign() {
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.backgroundColor = .black
    }
    
    func resultLabelDesign() {
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 0
        resultLabel.layer.borderColor = UIColor.black.cgColor
        resultLabel.layer.borderWidth = 1
        resultLabel.isHidden = true
    }
    
    func recommendButtonStackViewDesign() {
        recommendButtonStackView.spacing = 5
    }
    
    func recommendButtonListDesign() {
        let keys = Array(neologismDictionary.keys)
        for idx in 0...3 {
            recommendButtonList[idx].setTitle(keys[idx], for: .normal)
            recommendButtonList[idx].layer.cornerRadius = 5
            recommendButtonList[idx].layer.borderWidth = 1
            recommendButtonList[idx].layer.borderColor = UIColor.black.cgColor
            recommendButtonList[idx].tintColor = .black
            recommendButtonList[idx].backgroundColor = .white
            recommendButtonList[idx].clipsToBounds = true
            recommendButtonList[idx].titleLabel?.font = .systemFont(ofSize: 6)
        }
    }
    
    func iconImageViewDesign() {
        iconImageView.image = .wordLogo
        iconImageView.contentMode = .scaleAspectFill
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchTextFieldDidEndOnExit(searchTextField)
    }
    
    @IBAction func searchTextFieldDidEndOnExit(_ sender: UITextField) {
        let text = sender.text!
        search(text: text)
        sender.text = ""
    }
    
    @IBAction func recommendButtonTapped(_ sender: UIButton) {
        let text = sender.titleLabel!.text!
        search(text: text)
    }
    
    func search(text: String) {
        if iconImageView.isHidden == false {
            iconImageView.isHidden = true
            resultLabel.isHidden = false
        }
        let keys = Array(neologismDictionary.keys)
        if let key = keys.first(where: { $0.lowercased() == text.lowercased() }),
            let result = neologismDictionary[key] {
            resultLabel.text = result
        } else {
            resultLabel.text = "검색결과가 없습니다"
        }
        view.endEditing(true)
    }
    
    @IBAction func tapGestureTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

