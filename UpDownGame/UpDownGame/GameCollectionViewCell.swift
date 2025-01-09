//
//  GameCollectionViewCell.swift
//  UpDownGame
//
//  Created by 조성민 on 1/9/25.
//

import UIKit

final class GameCollectionViewCell: UICollectionViewCell {
    static let identifier: String = String(describing: GameCollectionViewCell.self)
    @IBOutlet private var numberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
        numberLabelDesign()
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
