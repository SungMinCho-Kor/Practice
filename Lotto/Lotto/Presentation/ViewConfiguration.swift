//
//  ViewConfiguration.swift
//  Lotto
//
//  Created by 조성민 on 1/14/25.
//

protocol ViewConfiguration: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}
