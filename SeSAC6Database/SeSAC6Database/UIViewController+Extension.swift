//
//  UIViewController+Extension.swift
//  SeSAC6Database
//
//  Created by 조성민 on 3/7/25.
//

import UIKit

// 저장하기 전에 실제 디바이스의 용량을 확인하기도 함 (부족한 경우 카톡처럼 Alert 띄우기도 함)

extension UIViewController {
    func saveImageToDocument(image: UIImage, filename: String) {
        
        // 도큐먼트 폴더 위치 가져오기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 이미지를 저장할 경로(파일명) 지정
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jgp")
        
        // 실제 저장하려는 이미지 파일
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        do {
            try data.write(to: fileURL)
        } catch {
            print("이미지 저장 실패!") //용량이 부족할때, 배터리 부족으로 종료될 때... 등
        }
    }
    
    func loadImageToDocument(filename: String) -> UIImage? {
        // 도큐먼트 폴더 위치 가져오기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        // 이미지를 불러올 경로(파일명) 지정
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jgp")
        
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else {
            return UIImage(systemName: "star")
        }
        
    }
    
    func removeImageFromDocument(filename: String) {
            guard let documentDirectory = FileManager.default.urls(
                for: .documentDirectory,
                in: .userDomainMask).first else { return }

            let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
            
            if FileManager.default.fileExists(atPath: fileURL.path()) {
                
                do {
                    try FileManager.default.removeItem(atPath: fileURL.path())
                } catch {
                    print("file remove error", error)
                }
                
            } else {
                print("file no exist")
            }
            
        }

}
