//
//  MainViewController.swift
//  SeSAC6Database
//
//  Created by Jack on 3/4/25.
//

import UIKit
import FSCalendar
import SnapKit
import RealmSwift

class MainViewController: UIViewController {

    let tableView = UITableView()
    let calendar = FSCalendar()
    
    private let repository: UserRepository = UserTableRepository()
    private let folderRepository: FolderRepository = FolderTableRepository()
    
    var list: Results<UserTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        repository.getFileURL()
        configureHierarchy()
        configureView()
        configureConstraints()
        list = repository.fetchAll()
        
        repository.getFileURL()
        
        
//        folderRepository.createItem(name: "계모임")
//        folderRepository.createItem(name: "개인")
//        folderRepository.createItem(name: "회사")
//        folderRepository.createItem(name: "멘토")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print(#function)
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(calendar)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        calendar.backgroundColor = .green
        calendar.delegate = self
        calendar.dataSource = self
        
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
          
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item
    }
    
    private func configureConstraints() {
        calendar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
        cell.titleLabel.text = data.name
        cell.subTitleLabel.text = data.category
        cell.overviewLabel.text = "\(data.money)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        repository.updateItem(data: data)
        tableView.reloadData()
    }
}

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource {
    
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        return 2
//    }
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "WRW"
//    }
    
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star")
//    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(#function, date)
        
        // 선택한 날짜
        let start = Calendar.current.startOfDay(for: date)
        
        // 선택한 날짜의 다음 날짜
        let end = Calendar.current.date(
            byAdding: .day,
            value: 1,
            to: start
        )!
        
        // Realm Filter를 위한 NSPredicate 만들기
        let predicate = NSPredicate(
            format: "date >= %@ && date < %@",
            start as NSDate, end as NSDate
        )
        
        let realm = try! Realm()
        
        let result = realm.objects(UserTable.self)
            .filter(predicate)
        
        dump(result)
        
    }
    
}
