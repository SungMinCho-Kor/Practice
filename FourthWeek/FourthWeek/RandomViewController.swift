//
//  RandomViewController.swift
//  FourthWeek
//
//  Created by 조성민 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

struct User: Decodable {
    let results: [UserDetail]
}

struct UserDetail: Decodable {
    let email: String
    let name: UserName
}

struct UserName: Decodable {
    let first: String
    let last: String
}

struct Dog: Decodable {
    let message: String
    let status: String
}

struct Lotto: Decodable {
    let drwNoDate: String
    let firstWinamnt: Int
}

protocol ViewConfiguration: AnyObject {
    func configureHierarchy()   // addSubview
    func configureLayout()      // SnapKit
    func configureView()        // Property
}

class RandomViewController: UIViewController, ViewConfiguration {
    
    let dogImageView = UIImageView()
    let nameLabel = UILabel()
    let randomButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(dogImageView)
        view.addSubview(nameLabel)
        view.addSubview(randomButton)
    }
    
    func configureLayout() {
        dogImageView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(dogImageView.snp.bottom).offset(20)
        }
        randomButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
    
    func configureView() {
        dogImageView.backgroundColor = .brown
        nameLabel.backgroundColor = .systemGreen
        randomButton.backgroundColor = .systemBlue
        randomButton.setTitle(
            "랜덤",
            for: .normal
        )
        randomButton.addTarget(
            self,
            action: #selector(randomButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc
    func randomButtonTapped(_ sender: UIButton) {
//        let url = "https://dog.ceo/api/breeds/image/random"
//        AF.request(url, method: .get).responseDecodable(of: Dog.self) { response in
//            switch response.result {
//            case .success(let model):
//                dump(model)
//            case .failure(let error):
//                dump(error)
//            }
//        }
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=888"
//        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
//            switch response.result {
//            case .success(let model):
//                dump(model)
//            case .failure(let error):
//                dump(error)
//            }
//        }
        let url = "https://randomuser.me/api/?results=5"
        AF.request(url, method: .get).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let model):
                dump(model)
            case .failure(let error):
                dump(error)
            }
        }
    }
    
}
