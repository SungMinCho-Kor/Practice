//
//  AdTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    @IBOutlet var backgroundColorView: UIView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adLabel.text = " AD "
        adLabel.font = .boldSystemFont(ofSize: 8)
        adLabel.layer.cornerRadius = 4
        adLabel.clipsToBounds = true
        adLabel.backgroundColor = .white
        
        backgroundColorView.layer.cornerRadius = 10
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center
        contentLabel.font = .systemFont(
            ofSize: 16,
            weight: .black
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentLabel.text = nil
        backgroundColorView.backgroundColor = .clear
    }
    
    func configure(
        _ content: Travel,
        row: Int
    ) {
        contentLabel.text = content.title
        let colors: [UIColor] = [
            .systemRed,
            .systemBlue,
            .systemPink,
            .systemPurple,
            .systemGreen,
            .systemCyan
        ]
        backgroundColorView.backgroundColor = colors[row % colors.count]
    }
}
