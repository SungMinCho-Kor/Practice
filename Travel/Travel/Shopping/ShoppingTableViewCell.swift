//
//  ShoppingTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/5/25.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var shoppingTitleLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .systemGray5
        checkButton.tintColor = .black
        shoppingTitleLabel.font = .systemFont(ofSize: 13)
        shoppingTitleLabel.numberOfLines = 0
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
