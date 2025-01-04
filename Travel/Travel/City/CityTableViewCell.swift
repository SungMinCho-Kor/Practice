//
//  CityTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starImageViewList: [UIImageView]!
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
}
