//
//  TravelDetailViewController.swift
//  Travel
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

final class TravelDetailViewController: UIViewController {
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var travelTitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var popButton: UIButton!
    
    var travel: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDesign()
        thumbnailImageViewDesign()
        travelTitleLabelDesign()
        descriptionLabelDesign()
        popButtonDesign()
        configure()
    }
    
    private func configure() {
        if let imageURLString = travel?.travel_image,
            let url = URL(string: imageURLString) {
            thumbnailImageView.kf.setImage(with: url)
        } else {
            print(#function, "Wrong Image URL in Travel")
            thumbnailImageView.image = UIImage(systemName: "photo")
        }
        travelTitleLabel.text = travel?.title
        descriptionLabel.text = travel?.description
    }
    
    private func navigationDesign() {
        navigationItem.title = "관광지 화면"
    }
    
    private func thumbnailImageViewDesign() {
        thumbnailImageView.layer.cornerRadius = 20
        thumbnailImageView.contentMode = .scaleAspectFill
    }
    
    private func travelTitleLabelDesign() {
        travelTitleLabel.font = .boldSystemFont(ofSize: 30)
        travelTitleLabel.numberOfLines = 0
        travelTitleLabel.textAlignment = .center
    }
    
    private func descriptionLabelDesign() {
        descriptionLabel.font = .boldSystemFont(ofSize: 22)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
    }
    
    private func popButtonDesign() {
        var attributedString = AttributedString("다른 관광지 보러가기")
        attributedString.font = .systemFont(ofSize: 16, weight: .bold)
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.attributedTitle = attributedString
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = .systemCyan
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 12,
            leading: 20,
            bottom: 12,
            trailing: 20
        )
        popButton.configuration = configuration
    }
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
