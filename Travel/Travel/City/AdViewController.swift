//
//  AdViewController.swift
//  Travel
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

class AdViewController: UIViewController {
    @IBOutlet private var adTitleLabel: UILabel!
    
    var adTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDesign()
        adTitleLabelDesign()
        configure()
    }
    
    private func navigationDesign() {
        navigationItem.title = "광고 화면"
        let xButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark")?.withTintColor(
                .black,
                renderingMode: .alwaysOriginal
            ),
            style: .plain,
            target: self,
            action: #selector(xButtonTapped)
        )
        navigationItem.leftBarButtonItem = xButton
    }
    
    private func configure() {
        adTitleLabel.text = adTitle
    }
    
    private func adTitleLabelDesign() {
        adTitleLabel.font = .systemFont(
            ofSize: 24,
            weight: .bold
        )
        adTitleLabel.textAlignment = .center
        adTitleLabel.numberOfLines = 0
    }

    @objc private func xButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}
