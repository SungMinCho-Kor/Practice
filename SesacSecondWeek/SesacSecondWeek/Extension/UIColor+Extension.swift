//
//  UIColor+Extension.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/6/25.
//

import UIKit

extension UIColor {
    // 저장 프로퍼티, 인스턴스 프로퍼티 X
//    var jackColor = UIColor.red
    
    // 저장 프로퍼티, 타입 프로퍼티 O
    static var backColor = UIColor.red
    
    // 연산 프로퍼티, 인스턴스 프로퍼티 O
    var denColor: UIColor {
        return UIColor.blue
    }
    
    // 연산 프로퍼티, 타입 프로퍼티 O
    static var brenColor: UIColor {
        return UIColor.red
    }
}
