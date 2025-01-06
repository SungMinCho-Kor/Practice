//
//  BasicTableViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/2/25.
//

import UIKit

class BasicTableViewController: UITableViewController {
    
    var list = ["프로젝1349th13984t[183ht[01h30[4th13[04ht0[13h4t18h4p9th13p4thp1934htp98h4tp93h4tph4p9thp394thp19384htp9138h4tp9138h4tp9813h4pt98h13p4t8h1p934t8hp13948htp9184htp91384htp트", "쇼핑", "메인 업무"] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return list.count
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        print(#function)
//        return 80
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "jackCell",
            for: indexPath
        )
        cell.textLabel?.text = list[indexPath.row]
        cell.textLabel?.font = .boldSystemFont(ofSize: 26)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "\(indexPath.row) detail"
        cell.detailTextLabel?.textColor = .red
        cell.detailTextLabel?.numberOfLines = 0
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
            "장프로젝1349th13984t[183ht[01h30[4th13[04ht0[13h4t18h4p9th13p4thp1934htp98h4tp93h4tph4p9thp394thp19384htp9138h4tp9138h4tp9813h4pt98h13p4t8h1p934t8hp13948htp9184htp91384htp트보기",
            "영화프로젝1349th13984t[183ht[01h30[4th13[04ht0[13h4t18h4p9th13p4thp1934htp98h4tp93h4tph4p9thp394thp19384htp9138h4tp9138h4tp9813h4pt98h13p4t8h1p934t8hp13948htp9184htp91384htp트보기",
            "쇼핑하기18h4p9th13p4thp1934htp9",
            "맛집탐방18h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp9",
            "새싹과제18h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp918h4p9th13p4thp1934htp9",
            "구현하기",
            "복습하기"
        ]
        list.append(randomTextList.randomElement()!)
//        tableView.reloadData()
    }
    
}
