//
//  BasicTableViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/2/25.
//

import UIKit

class BasicTableViewController: UITableViewController {
    
    var list = ["프로젝트", "쇼핑", "메인 업무"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.rowHeight = 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function)
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "jackCell",
            for: indexPath
        )
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.font = .boldSystemFont(ofSize: 26)
        cell.detailTextLabel?.text = "\(indexPath.row) detail"
        cell.detailTextLabel?.textColor = .red
        cell.backgroundColor = indexPath.row % 2 == 0 ? .gray : .systemBackground
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function, indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
//        tableView.reloadData()
    }
    
    @IBAction func randomAddButtonTapped(_ sender: UIBarButtonItem) {
        let randomTextList = [
            "장보기",
            "영화보기",
            "쇼핑하기",
            "맛집탐방",
            "새싹과제",
            "구현하기",
            "복습하기"
        ]
        list.append(randomTextList.randomElement()!)
//        tableView.reloadData()
    }
    
}
