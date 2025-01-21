//
//  NetworManager.swift
//  FiveWeek
//
//  Created by 조성민 on 1/20/25.
//

import Alamofire
import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    static let url = URL(string: "https://picsum.photos/200/200")!
    
    private init() { }
    
    func fetchImage(completionHandler: @escaping (UIImage) -> Void) {
        
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: NetworkManager.url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completionHandler(image)
                    }
                }
            }
        }
    }
    
}
