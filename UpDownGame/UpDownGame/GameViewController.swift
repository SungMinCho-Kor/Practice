//
//  ViewController.swift
//  UpDownGame
//
//  Created by 조성민 on 1/9/25.
//

import UIKit

final class GameViewController: UIViewController {
    @IBOutlet private var gameTitleLabel: UILabel!
    @IBOutlet private var countLabel: UILabel!
    @IBOutlet private var reactionImageView: UIImageView!
    @IBOutlet private var gameCollectionView: UICollectionView!
    @IBOutlet private var resultButton: UIButton!
    
    var list: [Int] = []
    
    private var count = 0 {
        didSet {
            countLabel.text = "시도 횟수: \(count)"
        }
    }
    var maxCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        gameTitleLabelDesign()
        countLabelDesign()
        reactionImageViewDesign()
        gameCollectionViewDesign()
        resultButtonDesign()
        configureGameCollectionView()
    }
}

extension GameViewController {
    private func viewDesign() {
        view.backgroundColor = .gamePrimary
    }
    
    private func gameTitleLabelDesign() {
        gameTitleLabel.text = "UP DOWN"
        gameTitleLabel.font = .systemFont(
            ofSize: 48,
            weight: .black
        )
        gameTitleLabel.textAlignment = .center
    }
    
    private func countLabelDesign() {
        countLabel.text = "시도 횟수: 0"
        countLabel.font = .systemFont(ofSize: 24)
        countLabel.textAlignment = .center
    }
    
    private func reactionImageViewDesign() {
        reactionImageView.image = UIImage.emotion1
        reactionImageView.contentMode = .scaleAspectFit
    }
    
    private func gameCollectionViewDesign() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        guard let sceneDelegate = UIApplication.shared.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            print(#function, "Wrong SceneDelegate")
            return
        }
        let screenWidth = window.bounds.width
        let sectionInset: CGFloat = 10
        let itemSpacing: CGFloat = 10
        let itemCount: CGFloat = 6
        let itemLength = (screenWidth - sectionInset * 2 - itemSpacing * (itemCount - 1))/itemCount
        layout.itemSize = CGSize(
            width: itemLength,
            height: itemLength
        )
        layout.sectionInset = UIEdgeInsets(
            top: sectionInset,
            left: sectionInset,
            bottom: sectionInset,
            right: sectionInset
        )
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        gameCollectionView.collectionViewLayout = layout
        gameCollectionView.backgroundColor = .gamePrimary
    }
    
    private func resultButtonDesign() {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .black
        configuration.baseForegroundColor = .white
        configuration.title = "결과 확인하기"
        resultButton.configuration = configuration
        resultButton.isEnabled = false
    }
    
    private func configureGameCollectionView() {
        let identifier = GameCollectionViewCell.identifier
        let nib = UINib(
            nibName: identifier,
            bundle: nil
        )
        gameCollectionView.register(
            nib,
            forCellWithReuseIdentifier: identifier
        )
        
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        list = Array(0...(maxCount ?? 1))
    }
}

extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return list.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GameCollectionViewCell.identifier,
            for: indexPath
        ) as? GameCollectionViewCell else {
            print(#function, "Wrong Cell identifier")
            return UICollectionViewCell()
        }
        
        return cell
    }
}
