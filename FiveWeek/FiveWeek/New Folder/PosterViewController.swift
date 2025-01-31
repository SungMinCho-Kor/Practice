//
//  PosterViewController.swift
//  FiveWeek
//
//  Created by 조성민 on 1/24/25.
//

import UIKit
import SnapKit

final class PosterViewController: UIViewController {
    
    private lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        return view
    }()
    
    var list = ["test1", "test2", "test3"]
    var detailList: [[String]] = [
        ["star", "person", "xmark"],
        ["star.fill", "star.fill", "star", "star.fill"],
        ["tray", "mic", "bubble", "phone", "envelope"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        PhotoManager.shared.getRandomPhoto { photo in
            dump(photo)
        } failHandler: {
            print("실패")
        }

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
        cell.titleLabel.text = list[indexPath.row]
        cell.collectionView.backgroundColor = .green
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        return cell
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        let data = detailList[collectionView.tag][indexPath.item]
        cell.posterImageView.image = UIImage(systemName: data)
        return cell
    }
    
}
