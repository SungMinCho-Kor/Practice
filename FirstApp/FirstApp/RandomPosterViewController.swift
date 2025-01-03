//
//  RandomPosterViewController.swift
//  FirstApp
//
//  Created by 조성민 on 12/26/24.
//

import UIKit

class RandomPosterViewController: UIViewController {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var sampleButton: UIButton!
    @IBOutlet var sampleLabel: UILabel!
    
    var nickname: String = "고래밥"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname = "칙촉"
        
        posterImageView.image = UIImage(named: "아바타")
        posterImageView.backgroundColor = UIColor(named: "pointColor")
        posterImageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        sampleButton.setTitle("랜덤 돌리기", for: .normal)
        sampleButton.setTitle("빨리 눌러줘", for: .highlighted)
        
        sampleButton.setTitleColor(.red, for: .normal)
        sampleButton.setTitleColor(.blue, for: .highlighted)
        
        sampleButton.backgroundColor = .yellow
        sampleButton.layer.cornerRadius = 16
        sampleButton.layer.borderWidth = 3
        sampleButton.layer.borderColor = UIColor.purple.cgColor
        
        sampleLabel.text = "안녕"
        sampleLabel.font = .boldSystemFont(ofSize: 24)
        sampleLabel.textColor = .red
        sampleLabel.textAlignment = .center
        
        sampleLabel.backgroundColor = .yellow
        sampleLabel.layer.cornerRadius = 16
        sampleLabel.layer.borderWidth = 3
        sampleLabel.layer.borderColor = UIColor.purple.cgColor
        
        sampleLabel.clipsToBounds = true
    }
    
    @IBAction func sampleButtonTapped(_ sender: UIButton) {
        let number = Int.random(in: 1...5)
        posterImageView.image = UIImage(named: "\(number)")
    }
    
}
