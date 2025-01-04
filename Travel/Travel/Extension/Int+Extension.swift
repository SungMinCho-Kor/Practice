//
//  Int+Extension.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import Foundation

extension Int {
    
    func changeToDecimalFormat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(integerLiteral: self)) ?? "0"
    }
    
}
