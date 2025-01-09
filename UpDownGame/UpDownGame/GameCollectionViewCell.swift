//
//  GameCollectionViewCell.swift
//  UpDownGame
//
//  Created by 조성민 on 1/9/25.
//

import UIKit

final class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
        numberLabelDesign()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .black : .white
            numberLabel.textColor = isSelected ? .white : .black
        }
    }
    
    func configure(number: Int) {
        numberLabel.text = "\(number)"
    }
}

extension GameCollectionViewCell {
    private func cellDesign() {
        backgroundColor = .white
    }
    
    private func numberLabelDesign() {
        numberLabel.textAlignment = .center
        numberLabel.numberOfLines = 0
    }
}
