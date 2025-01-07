//
//  MagazineTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

final class MagazineTableViewCell: UITableViewCell {
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
        thumbnailImageViewDesign()
        titleLabelDesign()
        subtitleLabelDesign()
        dateLabelDesign()
    }
    
    private func cellDesign() {
        selectionStyle = .none
    }
    
    private func thumbnailImageViewDesign() {
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 10
    }
    
    private func titleLabelDesign() {
        titleLabel.font = .systemFont(ofSize: 28, weight: .black)
        titleLabel.numberOfLines = 2
    }
    
    private func subtitleLabelDesign() {
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        subtitleLabel.textColor = .lightGray
    }
    
    private func dateLabelDesign() {
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .lightGray
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        titleLabel.text = ""
        subtitleLabel.text = ""
        dateLabel.text = ""
    }
    
    func configure(_ content: Magazine) {
        titleLabel.text = content.title
        subtitleLabel.text = content.subtitle
        thumbnailImageView.kf.setImage(with: URL(string: content.photo_image))
        if let date = Self.stringToDateFormatter.date(from: content.date) {
            dateLabel.text = Self.dateToStringFormatter.string(from: date)
        } else {
            print("wrong Date")
            dateLabel.text = ""
        }
    }
    
    // 아래의 기존 함수와 extension의 함수 혹은 static 변수를 활용한 방법의 메모리 차이를 확인하기 위해서
    // instrument와 debug navigator를 사용해봤으나 차이를 확인하기가 어렵습니다.
    // 메모리 성능 차이를 확인할 수 있는 방법이 있는지 궁금합니다!
    private func convertDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        guard let date = dateFormatter.date(from: date) else {
            print("잘못된 date 형식")
            return ""
        }
        dateFormatter.dateFormat = "yy년 M월 d일"
        
        return dateFormatter.string(from: date)
    }
}

extension MagazineTableViewCell {
    static var stringToDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
    static var dateToStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 M월 d일"
        return formatter
    }()
    
    static func convertDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        guard let date = dateFormatter.date(from: date) else {
            print("잘못된 date 형식")
            return ""
        }
        dateFormatter.dateFormat = "yy년 M월 d일"
        
        return dateFormatter.string(from: date)
    }
}
