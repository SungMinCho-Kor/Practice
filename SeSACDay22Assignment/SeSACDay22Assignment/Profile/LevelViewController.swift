//
//  LevelViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class LevelViewController: BaseViewController {
    private let segmentedControl = UISegmentedControl(items: ["상", "중", "하"])
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let level = UserDefaults.standard.string(forKey: "level") {
            if level == "상" {
                segmentedControl.selectedSegmentIndex = 0
            } else if level == "중" {
                segmentedControl.selectedSegmentIndex = 1
            } else {
                segmentedControl.selectedSegmentIndex = 2
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let level = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) else {
            return
        }
        NotificationCenter.default.post(
            name: NSNotification.Name("level"),
            object: nil,
            userInfo: ["level": level]
        )
    }
    
    @objc private func okButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func configureHierarchy() {
        view.addSubview(segmentedControl)
    }
    
    override func configureLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    override func configureViews() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        segmentedControl.selectedSegmentIndex = 0
    }
}
