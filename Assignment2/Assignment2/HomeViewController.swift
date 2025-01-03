//
//  HomeViewController.swift
//  Assignment2
//
//  Created by 조성민 on 12/27/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var mainBackgroundImageView: UIImageView!
    @IBOutlet var mainKeywordLabel: UILabel!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var addListButton: UIButton!
    @IBOutlet var hotContentsLabel: UILabel!
    @IBOutlet var firstHotContentsImageView: UIImageView!
    @IBOutlet var secondHotContentsImageView: UIImageView!
    @IBOutlet var thirdHotContentsImageView: UIImageView!
    
    @IBOutlet var smallIconImageViewList: [UIImageView]!
    
    @IBOutlet var topTenImageViewList: [UIImageView]!
    
    @IBOutlet var newEpisodeLabelList: [UILabel]!
    @IBOutlet var nowPlayLabelList: [UILabel]!
    
    var topTenIdx = 1
    var smallLogoIdx = 2
    var newEpisodeIdx = 1
    var nowPlayIdx = 1
    
    var imageNameList = ["오펜하이머", "밀수", "서울의봄", "스즈메의문단속", "아바타물의길", "콘크리트유토피아", "노량", "육사오"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainImageViewDesign()
        mainBackgroundImageViewDesign()
        mainKeywordLabelDesign()
        playButtonDesign()
        addListButtonDesign()
        hotContentsLabelDesign()
        firstHotContentsImageViewDesign()
        secondHotContentsImageViewDesign()
        thirdHotContentsImageViewDesign()
        topTenImageviewListDesign()
        smallIconImageViewListDesign()
        newEpisodeLabelListDesign()
        nowPlayLabelListDesign()
    }
    
    func mainImageViewDesign() {
        mainImageView.image = .노량
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 10
        mainImageView.clipsToBounds = true
    }
    
    func mainBackgroundImageViewDesign() {
        mainBackgroundImageView.image = .background
        mainBackgroundImageView.contentMode = .scaleAspectFill
        mainBackgroundImageView.layer.cornerRadius = 10
        mainBackgroundImageView.clipsToBounds = true
    }
    
    func mainKeywordLabelDesign() {
        mainKeywordLabel.text = "응원하고픈 · 흥미진진 · 사극 · 전투 · 한국 작품"
        mainKeywordLabel.textAlignment = .center
        mainKeywordLabel.font = .systemFont(ofSize: 13)
        mainKeywordLabel.textColor = .white
    }
    
    func playButtonDesign() {
        playButton.setImage(.playNormal, for: .normal)
        playButton.contentHorizontalAlignment = .fill
        playButton.contentVerticalAlignment = .fill
    }
    
    func addListButtonDesign() {
        addListButton.setTitle("내가 찜한 리스트", for: .normal)
        addListButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addListButton.titleLabel?.font = .systemFont(ofSize: 12)
    }
    
    func hotContentsLabelDesign() {
        hotContentsLabel.text = "지금 뜨는 콘텐츠"
        hotContentsLabel.font = .systemFont(ofSize: 17)
        hotContentsLabel.textColor = .white
    }
    
    func firstHotContentsImageViewDesign() {
        firstHotContentsImageView.image = .아바타물의길
        firstHotContentsImageView.contentMode = .scaleAspectFill
        firstHotContentsImageView.layer.cornerRadius = 10
        firstHotContentsImageView.clipsToBounds = true
    }
    
    func secondHotContentsImageViewDesign() {
        secondHotContentsImageView.image = .범죄도시3
        secondHotContentsImageView.contentMode = .scaleAspectFill
        secondHotContentsImageView.layer.cornerRadius = 10
        secondHotContentsImageView.clipsToBounds = true
    }
    
    func thirdHotContentsImageViewDesign() {
        thirdHotContentsImageView.image = .오펜하이머
        thirdHotContentsImageView.contentMode = .scaleAspectFill
        thirdHotContentsImageView.layer.cornerRadius = 10
        thirdHotContentsImageView.clipsToBounds = true
    }
    
    
    func topTenImageviewListDesign() {
        for idx in 0...2 {
            topTenImageViewList[idx].image = .top10Badge
            topTenImageViewList[idx].tag = idx
            topTenImageViewList[idx].isHidden = true
        }
        topTenImageViewList[topTenIdx].isHidden = false
    }
    
    func smallIconImageViewListDesign() {
        for idx in 0...2 {
            smallIconImageViewList[idx].image = .singleSmall
            smallIconImageViewList[idx].tag = idx
            smallIconImageViewList[idx].isHidden = true
        }
        smallIconImageViewList[smallLogoIdx].isHidden = false
    }
    
    func newEpisodeLabelListDesign() {
        for idx in 0...2 {
            newEpisodeLabelList[idx].text = "새로운 에피소드"
            newEpisodeLabelList[idx].font = .systemFont(ofSize: 12, weight: .semibold)
            newEpisodeLabelList[idx].backgroundColor = .red
            newEpisodeLabelList[idx].layer.cornerRadius = 4
            newEpisodeLabelList[idx].clipsToBounds = true
            newEpisodeLabelList[idx].textColor = .white
            newEpisodeLabelList[idx].textAlignment = .center
            newEpisodeLabelList[idx].isHidden = true
        }
        newEpisodeLabelList[newEpisodeIdx].isHidden = false
    }
    
    func nowPlayLabelListDesign() {
        for idx in 0...2 {
            nowPlayLabelList[idx].text = "지금 시청하기"
            nowPlayLabelList[idx].font = .systemFont(ofSize: 12, weight: .semibold)
            nowPlayLabelList[idx].backgroundColor = .white
            nowPlayLabelList[idx].layer.cornerRadius = 4
            nowPlayLabelList[idx].clipsToBounds = true
            nowPlayLabelList[idx].textColor = .black
            nowPlayLabelList[idx].textAlignment = .center
            nowPlayLabelList[idx].isHidden = true
        }
        nowPlayLabelList[nowPlayIdx].isHidden = false
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        topTenImageViewList[topTenIdx].isHidden = true
        smallIconImageViewList[smallLogoIdx].isHidden = true
        newEpisodeLabelList[newEpisodeIdx].isHidden = true
        nowPlayLabelList[nowPlayIdx].isHidden = true
        topTenIdx = Int.random(in: 0...2)
        smallLogoIdx = Int.random(in: 0...2)
        newEpisodeIdx = Int.random(in: 0...2)
        nowPlayIdx = Int.random(in: 0...2)
        topTenImageViewList[topTenIdx].isHidden = false
        smallIconImageViewList[smallLogoIdx].isHidden = false
        newEpisodeLabelList[newEpisodeIdx].isHidden = false
        nowPlayLabelList[nowPlayIdx].isHidden = false
        
        imageNameList.shuffle()
        mainImageView.image = UIImage(named: imageNameList[0])
        firstHotContentsImageView.image = UIImage(named: imageNameList[1])
        secondHotContentsImageView.image = UIImage(named: imageNameList[2])
        thirdHotContentsImageView.image = UIImage(named: imageNameList[3])
    }
    
}
