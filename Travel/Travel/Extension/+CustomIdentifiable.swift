//
//  UITableViewCell+Identifier.swift
//  Travel
//
//  Created by 조성민 on 1/6/25.
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

extension UITableViewCell: CustomIdentifiable {}
extension UICollectionViewCell: CustomIdentifiable {}
extension UIViewController: CustomIdentifiable {}
