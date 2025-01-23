//
//  BirthdayViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class BirthdayViewController: BaseViewController {
    var delegate: PassDataDelegate?
    
    private let datePicker = UIDatePicker()
    
    @objc func okButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let birthdayString = UserDefaults.standard.string(forKey: "birthday") {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy. M. d"
            datePicker.date = dateFormatter.date(from: birthdayString) ?? Date()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.passBirthday(date: datePicker.date)
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureViews() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
}

protocol PassDataDelegate {
    func passBirthday(date: Date)
}
