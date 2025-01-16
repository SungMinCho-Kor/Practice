//
//  NetworkManager.swift
//  Shopping
//
//  Created by 조성민 on 1/16/25.
//

import Foundation
import Alamofire

enum NetworkError: Error, LocalizedError {
    case S1_S4orS6
    case S5
    case S99
    case authorization
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .S1_S4orS6:
            return "400 Error S1~S4, S6 확인"
        case .S5:
            return "404 Error S5 확인"
        case .S99:
            return "500 Error S99 확인"
        case .authorization:
            return "401 Error Client Key and Secret 확인"
        case .unknown:
            return "알 수 없는 에러"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchShoppingList(form: FetchShoppingListForm) async throws -> ShoppingItemList {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(form.query)&display=30&sort=\(form.sort)&start=\(form.start)"
        let header = HTTPHeaders([
            "X-Naver-Client-Id": APIKey.naverClientID,
            "X-Naver-Client-Secret": APIKey.naverSecretKey
        ])
        
        let data = AF.request(url, method: .get)
            .serializingDecodable(ShoppingItemList.self)
        
        let response = await data.response
        try handleStatusCode(response.response?.statusCode)
        switch response.result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
    
    private func handleStatusCode(_ code: Int?) throws {
        dump(code)
        switch code {
        case 200:
            break
        case 400:
            throw NetworkError.S1_S4orS6
        case 404:
            throw NetworkError.S5
        case 401:
            throw NetworkError.authorization
        case 500:
            throw NetworkError.S99
        default:
            throw NetworkError.unknown
        }
    }
}
