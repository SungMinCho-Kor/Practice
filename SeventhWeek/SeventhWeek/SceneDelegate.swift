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
        window?.rootViewController = PersonListViewController()
        window?.makeKeyAndVisible()
    }
}
