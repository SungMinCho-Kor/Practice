//
//  MarketTableViewCell.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import SnapKit

class MarketTableViewCell: UITableViewCell {
    
    static let id = "MarketTableViewCell"
    
    let nameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
        
    }
    
    func configureHierarchy() {
        contentView.addSubview(nameLabel)
    }
    
    func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
    }
    
    func configureView() {
        nameLabel.textColor = .brown
        nameLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
