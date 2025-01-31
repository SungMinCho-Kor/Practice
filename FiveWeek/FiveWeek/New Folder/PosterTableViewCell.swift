//
//  PosterTableViewCell.swift
//  FiveWeek
//
//  Created by 조성민 on 1/24/25.
//

import UIKit

class PosterTableViewCell: UITableViewCell {
    static let id = "PosterTableViewCell"

    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 17)
        view.text = "비슷한 영화"
        view.textColor = .black
        return view
    }()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())

    static private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
        }
    }
}
