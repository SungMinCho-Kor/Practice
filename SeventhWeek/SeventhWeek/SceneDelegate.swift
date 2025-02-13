//
//  SceneDelegate.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/3/25.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: NotificationViewController())
        window?.makeKeyAndVisible()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Badge 제거
        UNUserNotificationCenter.current().setBadgeCount(0)
        
        // 쌓여있던 알림센터 제거
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        // 사용자에게 아직 전달되지 않았지만 앞으로 전달될 알림을 제거
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
