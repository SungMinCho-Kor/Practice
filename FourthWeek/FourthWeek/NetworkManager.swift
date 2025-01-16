//
//  NetworkManager.swift
//  FourthWeek
//
//  Created by 조성민 on 1/16/25.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func randomUser(completionHandler: (String) -> ()) {
        let url = "https://randomuser.me/api/?results=5"
        AF.request(url, method: .get).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let model):
                dump(model)
            case .failure(let error):
                dump(error)
            }
        }
    }
    
}
