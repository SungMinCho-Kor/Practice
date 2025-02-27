//
//  CompositionalCollectionViewCell.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/27/25.
//

import UIKit
import SnapKit

final class CompositionalCollectionViewCell: UICollectionViewCell {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        backgroundColor = .systemBlue
        label.backgroundColor = .systemYellow
        label.textAlignment = .center
        label.textColor = .orange
    }
    
    func configure(text: String) {
        label.text = text
    }
}
