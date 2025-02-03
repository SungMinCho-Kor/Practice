//
//  NetworkManager.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/3/25.
//

import Alamofire

struct Lotto: Decodable {
    let drwNo1: String
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getLotto(successHandler: @escaping (Lotto) -> Void,
                        failHandler: @escaping () -> Void) {
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    successHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    func getLotto2(completion: @escaping (Lotto?, AFError?) -> Void) {
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
    func getLotto3(completion: @escaping (Result<Lotto, AFError>) -> Void) {
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
