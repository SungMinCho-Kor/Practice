//
//  UILabel+Extension.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/2/25.
//

import UIKit

extension UILabel {
    
    func setPrimaryLabel(_ text: String) {
        self.font = .boldSystemFont(ofSize: 20)
        self.textColor = .green
        self.textAlignment = .center
        self.text = text
    }
    
}
