//
//  AdTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

final class AdTableViewCell: UITableViewCell {
    @IBOutlet private var backgroundColorView: UIView!
    @IBOutlet private var contentLabel: UILabel!
    @IBOutlet private var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adLabelDesign()
        backgroundColorViewDesign()
        contentLabelDesign()
    }
    
    private func adLabelDesign() {
        adLabel.text = " AD "
        adLabel.font = .boldSystemFont(ofSize: 8)
        adLabel.layer.cornerRadius = 4
        adLabel.clipsToBounds = true
        adLabel.backgroundColor = .white
    }
    
    private func backgroundColorViewDesign() {
        backgroundColorView.layer.cornerRadius = 10
    }
    
    private func contentLabelDesign() {
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
