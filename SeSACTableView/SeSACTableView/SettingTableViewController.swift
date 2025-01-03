//
//  SettingTableViewController.swift
//  SeSACTableView
//
//  Created by 조성민 on 1/3/25.
//

import UIKit

struct SettingCellContent {
    let sectionTitle: String
    let rowTitleList: [String]
}

class SettingTableViewController: UITableViewController {
    
    let cellContentList: [SettingCellContent] = [
        SettingCellContent(
            sectionTitle: "전체 설정",
            rowTitleList: [
                "공지 사항",
                "실험실",
                "버전 정보"
            ]
        ),
        SettingCellContent(
            sectionTitle: "개인 설정",
            rowTitleList: [
                "개인/보안",
                "알림",
                "채팅",
                "멀티 프로필"
            ]
        ),
        SettingCellContent(
            sectionTitle: "기타",
            rowTitleList: [
                "고객센터/도움말"
            ]
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellContentList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return cellContentList[section].sectionTitle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContentList[section].rowTitleList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        cell.textLabel?.text = cellContentList[indexPath.section].rowTitleList[indexPath.row]
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
}
