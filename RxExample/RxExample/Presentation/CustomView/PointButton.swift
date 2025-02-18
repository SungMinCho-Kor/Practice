//
//  PointButton.swift
//  RxExample
//
//  Created by 조성민 on 2/18/25.
//

import UIKit

class PointButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(Color.white, for: .normal)
        backgroundColor = Color.black
        layer.cornerRadius = 10 
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
