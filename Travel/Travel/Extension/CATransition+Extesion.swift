//
//  CATransition+Extesion.swift
//  Travel
//
//  Created by 조성민 on 1/12/25.
//

import UIKit

extension CATransition {
    func pushFromLeft() -> CATransition {
        duration = 0.6
        type = .push
        subtype = .fromRight
        timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        return self
    }
    
    func popFromRight() -> CATransition {
        duration = 0.6
        type = .reveal
        subtype = .fromLeft
        timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        return self
    }
}
