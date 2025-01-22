//
//  GroupViewController.swift
//  FiveWeek
//
//  Created by 조성민 on 1/21/25.
//

import UIKit
import Kingfisher

class GroupViewController: UIViewController {
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
    
    var firstValue = ""
    var secondValue = ""
    var thirdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = .white
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
    
    @objc
    private func checkButtonTappp(_ sender: UITapGestureRecognizer) {
        print(#function)
        let group = DispatchGroup()
        
        group.enter()
        PhotoManager.shared.getRandomPhoto { photo in
            print(photo.id)
            self.firstValue = photo.urls.thumb
            group.leave()
        } failHandler: {
            group.leave()
        }
        
        group.enter()
        PhotoManager.shared.getRandomPhoto { photo in
            print(photo.id)
            self.secondValue = photo.urls.thumb
            group.leave()
        } failHandler: {
            group.leave()
        }
        
        group.enter()
        PhotoManager.shared.getRandomPhoto { photo in
            print(photo.id)
            self.thirdValue = photo.urls.thumb
            group.leave()
        } failHandler: {
            group.leave()
        }
        
        group.notify(queue: .main) {
            print()
            self.firstImageView.kf.setImage(with: URL(string: self.firstValue))
            self.secondImageView.kf.setImage(with: URL(string: self.secondValue))
            self.thirdImageView.kf.setImage(with: URL(string: self.thirdValue))
        }
        
        PhotoManager.shared.getAPhoto(id: "yd4daZHEtcA")
        PhotoManager.shared.getATopic(id: "wallpapers")
        
    }
    
    
}
