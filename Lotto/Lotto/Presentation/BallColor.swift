//
//  BallColor.swift
//  Lotto
//
//  Created by 조성민 on 2/24/25.
//

import UIKit

enum BallColor {
    case yellow
    case blue
    case red
    case gray
    case green
    
    var uiColor: UIColor {
        switch self {
        case .yellow:
            return .systemYellow
        case .blue:
            return .systemBlue
        case .red:
            return .systemRed
        case .gray:
            return .gray
        case .green:
            return .systemGreen
        }
    }
}
