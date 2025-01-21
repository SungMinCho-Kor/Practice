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
    
    func callBook(searchText: String, page: Int, completionHandler: @escaping (Book) -> Void) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(searchText)&size=30&page=\(page)"
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(APIKey.kakao)"
        ]
        
        AF.request(url, method: .get, headers: headers)
//            .responseString { value in
//                dump(value)
//            }
            .validate()
            .responseDecodable(of: Book.self) { response in
                print(response.response?.statusCode)
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    dump(error)
                }
            }
    }
    
    func callBook(searchText: String, page: Int, completionHandler: @escaping (Book) -> Void) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(searchText)&size=30&page=\(page)"
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(APIKey.kakao)"
        ]
        
        AF.request(url, method: .get, headers: headers)
//            .responseString { value in
//                dump(value)
//            }
            .validate()
            .responseDecodable(of: Book.self) { response in
                print(response.response?.statusCode)
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    dump(error)
                }
            }
    }
    
}
