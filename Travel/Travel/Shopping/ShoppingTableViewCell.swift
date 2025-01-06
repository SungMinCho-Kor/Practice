//
//  ShoppingTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/5/25.
//

import UIKit

final class ShoppingTableViewCell: UITableViewCell {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private(set) var checkButton: UIButton!
    @IBOutlet private var shoppingTitleLabel: UILabel!
    @IBOutlet private(set) var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
        containerViewDesign()
        checkButtonDesign()
        shoppingTitleLabelDesign()
        favoriteButtonDesign()
    }
    
    private func cellDesign() {
        selectionStyle = .none
    }
    
    private func containerViewDesign() {
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .systemGray5
    }
    
    private func checkButtonDesign() {
        checkButton.tintColor = .black
    }
    
    private func shoppingTitleLabelDesign() {
        shoppingTitleLabel.font = .systemFont(ofSize: 13)
        shoppingTitleLabel.numberOfLines = 0
    }
    
    private func favoriteButtonDesign() {
        favoriteButton.tintColor = .black
    }
    
    func configure(_ content: ShoppingListContent) {
        let checkImage = UIImage(systemName: content.checked ? "checkmark.square.fill" : "checkmark.square")
        checkButton.setImage(
            checkImage?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 12)),
            for: .normal
        )
        shoppingTitleLabel.text = content.title
        let favoriteImage = UIImage(systemName: content.favorite ? "star.fill" : "star")
        favoriteButton.setImage(
            favoriteImage?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 12)),
            for: .normal
        )
    }
}
