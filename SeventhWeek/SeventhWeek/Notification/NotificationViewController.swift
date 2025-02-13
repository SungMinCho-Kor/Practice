//
//  NotificationViewController.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/13/25.
//

import UIKit

// foreground에서는 알림이 안 뜨는 것이 default
// fore에서 받고 싶으면 delegate 설정이 필요
// timeinterval repeat은 60초 이상부터 가능
// 알림 센터에 스택 쌓이는 기준은 identifier
// 알림센터에 보이고 있는 지, 사용자에게 전달되어있는 지 알수 없음
// 단, 사용자가 알람을 '클릭'했을 때만 확인 가능
// identifier: 고유값 / 64개 제한
// content의 userInfo를 이용하여 알림을 특정지을 수 있다.
// 64개 초과하여 한 번에 등록 불가능

class NotificationViewController: UIViewController {
    private let requestButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func configureHierarchy() {
        view.addSubview(requestButton)
    }
    
    private func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        requestButton.backgroundColor = .blue
        requestButton.addTarget(
            self,
            action: #selector(requestButtonClicked),
            for: .touchUpInside
        )
    }
    
    @objc private func requestButtonClicked() {
        print(#function)
        
        let content = UNMutableNotificationContent()
        content.title = "테스트 UserInfo 활용"
        content.subtitle = "\(Int.random(in: 0...100))"
        content.sound = .default
        content.userInfo = ["type": 2]
        
        
        // repeat은 timeInterval 최소값이 60이다.
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 2,
            repeats: false
        )
        
//        var components = DateComponents()
//        components.minute = 18
//        
//        let trigger = UNCalendarNotificationTrigger(
//            dateMatching: components,
//            repeats: false
//        )
        
        let request = UNNotificationRequest(
            identifier: "\(Date())",
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
    
}
