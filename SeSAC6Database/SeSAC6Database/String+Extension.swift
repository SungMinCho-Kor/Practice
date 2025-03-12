//
//  String+Extension.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/12/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(with: String) -> String {
        String(format: localized, with)
    }
    
    func localized(number: Int) -> String {
        String(format: localized, number)
    }
}
