//
//  SettingViewController.swift
//  ThirdWeek
//
//  Created by 조성민 on 1/10/25.
//

import UIKit

enum SettingOptions: String, CaseIterable {
    
    case total = "전체 설정"
    case personal = "개인 설정"
    case ohters = "기타 설정"
    
    var rowList: [String] {
        switch self {
        case .total:
            return [
                "공지사항",
                "실험실",
                "버전정보"
            ]
        case .personal:
            return [
                "개인/보안",
                "알림",
                "채팅"
            ]
        case .ohters:
            return [
                "고객센터/도움말"
            ]
        }
    }
}

class SettingViewController: UIViewController {
    
    let options: [SettingOptions] = SettingOptions.allCases
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return options[section].rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].rowList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BasicCell",
            for: indexPath
        )
        cell.textLabel?.text = options[indexPath.section].rowList[indexPath.row]
        return cell
    }
}
