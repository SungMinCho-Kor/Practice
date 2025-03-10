//
//  AppDelegate.swift
//  SeSAC6Database
//
//  Created by Jack on 3/4/25.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        realmMigration()
//        현재 사용자가 사용하는 DB Schema Version 체크
        let realm = try! Realm()
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version : ", version)
        } catch {
            print("Schema Failed")
        }
        
        return true
    }
    
    func realmMigration() {
        let config = Realm.Configuration(schemaVersion: 8) { migration, oldSchemaVersion in
            // 단순히 테이블, 컬럼 추가 삭제에는 코드 필요 X
            
            // 0 -> 1: Folder에 like: Bool 추가
            if oldSchemaVersion < 1 {
                
            }
            
            // 1 -> 2: Folder에 like: Bool 삭제
            if oldSchemaVersion < 2 {
                
            }
            
            // 2 -> 3: Folder에 like: Bool 추가
            if oldSchemaVersion < 3 {
                
            }
            
            // 3 -> 4 like = true 기본 설정
            if oldSchemaVersion < 4 {
                migration.enumerateObjects(ofType: Folder.className()) { oldObject, newObject in
                    
                    guard let newObject else { return }
                    
                    newObject["like"] = true
                }
            }
            
            // 4 -> 5 like 이름 favorite으로 수정
            if oldSchemaVersion < 5 {
                migration.renameProperty(
                    onType: Folder.className(),
                    from: "like",
                    to: "favorite"
                )
            }
            
            // 5 -> 6 Folder의 nameDescription을 기존 필드의 내용으로 만들어 채우기
            if oldSchemaVersion < 6 {
                migration.enumerateObjects(ofType: Folder.className()) { oldObject, newObject in
                    guard let oldObject, let newObject else {
                        return
                    }
                    newObject["nameDescription"] = "'\(oldObject["name"] ?? "")'폴더에 대한 설명입니다."
                }
            }
            
            // 6 -> 7 Folder에 EmbededObject Memo 생성
            if oldSchemaVersion < 7 {
                
            }
            
            // 7 -> 8 UserTable에 poster 생성
            if oldSchemaVersion < 8 {
                
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

