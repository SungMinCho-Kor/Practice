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
    
    private var list: [Int] = []
    private var count = 0 {
        didSet {
            countLabel.text = "시도 횟수: \(count)"
        }
    }
    var maxCount: Int = 0
    private var correctNumber: Int = 0
    private var selectedNumber: Int? {
        didSet {
            resultButton.isEnabled = selectedNumber != nil
        }
    }
    private var selectedIndexpath: IndexPath?
    
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
        gameTitleLabel.textColor = .black
    }
    
    private func countLabelDesign() {
        countLabel.text = "시도 횟수: 0"
        countLabel.font = .systemFont(ofSize: 24)
        countLabel.textAlignment = .center
    }
    
    private func reactionImageViewDesign() {
        reactionImageView.image = UIImage.emotion1
        reactionImageView.contentMode = .scaleAspectFill
    }
    
    private func gameCollectionViewDesign() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
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
        resultButton.addTarget(
            self,
            action: #selector(resultButtonTapped),
            for: .touchUpInside
        )
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
        list = Array(1...maxCount)
        correctNumber = Int.random(in: 1...maxCount)
    }
    
    @objc
    private func resultButtonTapped(_ sender: UIButton) {
        guard let selectedIndexpath else {
            return
        }
        
        if list[selectedIndexpath.row] > correctNumber {
            list = Array<Int>(list[0..<selectedIndexpath.row])
            gameTitleLabel.text = "DOWN"
            reactionImageView.image = .emotion4
        } else if list[selectedIndexpath.row] < correctNumber {
            list = Array<Int>(list[selectedIndexpath.row+1..<list.count])
            gameTitleLabel.text = "UP"
            reactionImageView.image = .emotion3
        } else {
            list = []
            gameTitleLabel.text = "GOOD"
            reactionImageView.image = .emotion2
        }
        
        selectedNumber = nil
        self.selectedIndexpath = nil
        gameCollectionView.reloadData()
        gameCollectionView.scrollToItem(
            at: IndexPath(
                row: -1,
                section: 0
            ),
            at: .left,
            animated: true
        )
        count += 1
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
        cell.configure(number: list[indexPath.item])
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        selectedNumber = list[indexPath.row]
        selectedIndexpath = indexPath
    }
}
