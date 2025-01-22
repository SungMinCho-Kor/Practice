//
//  PhotoManager.swift
//  FiveWeek
//
//  Created by 조성민 on 1/21/25.
//

import Foundation
import Alamofire

enum UnsplashRequest {
    
    case randomPhoto
    case topic(id: String)
    case photo(query: String)
    
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    
    var endpoint: URL {
        switch self {
        case .randomPhoto:
            return URL(string: baseURL + "/photos/random")!
        case .topic(let id):
            return URL(string: baseURL + "/topics/\(id)")!
        case .photo(let query):
            return URL(string: baseURL + "/photos/\(query)")!
        }
    }
    
    var header: HTTPHeaders {
        [
            "Authorization": "Client-ID \(Key.unsplash)"
        ]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        return [
            "page":"1",
            "color":"white",
            "order_by":"relevant"
        ]
    }
}

class PhotoManager {
    static let shared = PhotoManager()
    
    private init() { }
    
    func getRandomPhoto(
        completion: @escaping (RandomPhoto) -> Void,
        failHandler: @escaping () -> Void
    ) {
        let url = "https://api.unsplash.com/photos/random"
        
        let header: HTTPHeaders = [
            "Authorization": "Client-ID \(Key.unsplash)"
        ]
        
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completion(value)
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    
    func getAPhoto(id: String) {
        let url = "https://api.unsplash.com/photos/\(id)"
                
                let header: HTTPHeaders = [
                    "Authorization": "Client-ID \(Key.unsplash)"
                ]
                
                AF.request(url, method: .get, headers: header)
                    .validate(statusCode: 200..<500)
                    .responseDecodable(of: RandomPhoto.self) { response in
                        switch response.result {
                        case .success(let value):
                            print(value)
                        case .failure(let error):
                            print(error)
                        }
                    }
    }
    
    func getATopic(id: String) {
        let url = "https://api.unsplash.com/topics/\(id)"
                
                let header: HTTPHeaders = [
                    "Authorization": "Client-ID \(Key.unsplash)"
                ]
                
                AF.request(url, method: .get, headers: header)
                    .validate(statusCode: 200..<500)
                    .responseDecodable(of: Topic.self) { response in
                        switch response.result {
                        case .success(let value):
                            print(value)
                        case .failure(let error):
                            print(error)
                        }
                    }
    }
    
    func request(api: UnsplashRequest) {
        AF.request(
            api.endpoint,
            method: api.method,
            headers: api.header
        )
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Topic.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

struct Topic: Decodable {
    let title: String
    let description: String
    let total_photos: Int
    let cover_photo: TopicCoverPhoto
}

struct TopicCoverPhoto: Decodable {
    let urls: TopicURL
}

struct TopicURL: Decodable {
    let thumb: String
}
