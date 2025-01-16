//
//  BaseCollectionViewCell.swift
//  Shopping
//
//  Created by 조성민 on 1/16/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    static var identifier: String { String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureHierarchy()
        configureLayout()
        configureViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureViews() { }
}
