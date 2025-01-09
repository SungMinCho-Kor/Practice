//
//  CustomIdentifiable+.swift
//  UpDownGame
//
//  Created by 조성민 on 1/9/25.
//

import UIKit

protocol CustomIdentifiable {
    static var identifier: String { get }
}

extension CustomIdentifiable {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: CustomIdentifiable {}
extension UIViewController: CustomIdentifiable {}
