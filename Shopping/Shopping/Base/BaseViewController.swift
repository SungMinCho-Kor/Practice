//
//  BaseViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureHierarchy()
        configureLayout()
        configureViews()
    }
    
    func configureNavigation() { }
    
    func configureHierarchy() { }
    
    func configureLayout() { }
    
    func configureViews() { }
}

