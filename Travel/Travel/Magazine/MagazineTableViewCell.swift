//
//  MagazineTableViewCell.swift
//  Travel
//
//  Created by 조성민 on 1/4/25.
//

import UIKit

class MagazineTableViewCell: UITableViewCell {
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.layer.cornerRadius = 10
        titleLabel.font = .systemFont(ofSize: 28, weight: .black)
        titleLabel.numberOfLines = 2
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        subtitleLabel.textColor = .lightGray
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
        dateLabel.text = convertDateFormat(date: content.date)
    }
    
    // TODO: 메모리 관점에서 타입 메서드로 개선
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
