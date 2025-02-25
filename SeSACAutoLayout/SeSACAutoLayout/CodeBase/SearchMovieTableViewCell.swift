//
//  SearchMovieTableViewCell.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 1/13/25.
//

import UIKit

final class SearchMovieTableViewCell: UITableViewCell {

    static let identifier = "SearchMovieTableViewCell"
    private let indexLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(
            ofSize: 20,
            weight: .semibold
        )
        return label
    }()
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(
            ofSize: 16,
            weight: .bold
        )
        label.setContentCompressionResistancePriority(
            .defaultLow,
            for: .horizontal
        )
//        label.setContentHuggingPriority(
//            .defaultLow,
//            for: .horizontal
//        )
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal
        )
//        label.setContentHuggingPriority(
//            .defaultHigh,
//            for: .horizontal
//        )
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        indexLabel.text = ""
        movieTitleLabel.text = ""
        dateLabel.text = ""
    }
}

//MARK: Design
extension SearchMovieTableViewCell {
    private func setCellStyle() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setUI() {
        [
            indexLabel,
            movieTitleLabel,
            dateLabel
        ].forEach(contentView.addSubview)
    }
    
    private func setLayout() {
        indexLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(indexLabel.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(dateLabel.snp.leading).offset(-16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
}

//MARK: Configure
extension SearchMovieTableViewCell {
    func configure(_ content: Movie) {
        indexLabel.text = "\(content.rank)"
        movieTitleLabel.text = content.movieNm
        dateLabel.text = content.openDt
    }
}
