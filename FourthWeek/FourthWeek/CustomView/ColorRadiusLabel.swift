//
//  ColorRadiusLabel.swift
//  FourthWeek
//
//  Created by 조성민 on 1/15/25.
//

import UIKit

class ColorRadiusLabel: UILabel {
    
    init(_ color: UIColor) {
        super.init(frame: .zero)
        
        font = .boldSystemFont(ofSize: 15)
        textColor = .white
        backgroundColor = color
        layer.cornerRadius = 10
        clipsToBounds = true
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
