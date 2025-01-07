//
//  UIViewController+Identifier.swift
//  Travel
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

extension UIViewController {
    static var identifier: String {
        String(describing: self)
    }
}
