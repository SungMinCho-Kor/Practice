//
//  NetworkManager.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/24/25.
//

import Foundation
import Alamofire
import RxSwift

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init () { }
    
    func callBoxOffice(
        date: String,
        completionHandler: @escaping (Result<Movie, APIError>) -> Void
    ) {
        
        let urlString =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=6f880d27184cbe92e28d4970282cec8e&targetDt=\(date)"
        
        guard let url = URL(string: urlString ) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completionHandler(.failure(.unknownResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                completionHandler(.failure(.statusError))
                return
            }
            
            if let data {
                do {
                    let result = try JSONDecoder().decode(Movie.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(.unknownResponse))
                }
            } else {
                completionHandler(.failure(.unknownResponse))
            }
        }
        .resume()
    }
    
//    func callBoxOffice(date: String) -> Observable<Movie> {
//        return Observable<Movie>.create { observer in
//            let urlString =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=6f880d27184cbe92e28d4970282cec8e&targetDt=\(date)"
//            
//            guard let url = URL(string: urlString ) else {
//                observer.onError(APIError.invalidURL)
//                return Disposables.create {
//                    print("URL ERROR!")
//                }
//            }
//            
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error {
//                    observer.onError(APIError.unknownResponse)
//                    return
//                }
//                
//                guard let response = response as? HTTPURLResponse,
//                      (200...299).contains(response.statusCode) else {
//                    observer.onError(APIError.statusError)
//                    return
//                }
//                
//                if let data {
//                    do {
//                        let result = try JSONDecoder().decode(Movie.self, from: data)
//                        observer.onNext(result)
//                    } catch {
//                        observer.onError(APIError.unknownResponse)
//                    }
//                } else {
//                    observer.onError(APIError.unknownResponse)
//                }
//            }
//            .resume()
//            
//            return Disposables.create {
//                print("끝!")
//            }
//        }
//        
//    }
    
    func callBoxOffice(date: String) -> Single<Movie> {
        return Single<Movie>.create { observer in
            observer(.failure(APIError.unknownResponse))
            let urlString =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=6f880d27184cbe92e28d4970282cec8e&targetDt=\(date)"
            
            guard let url = URL(string: urlString ) else {
                observer(.failure(APIError.invalidURL))
                return Disposables.create {
                    print("URL ERROR!")
                }
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    observer(.failure(APIError.unknownResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    observer(.failure(APIError.statusError))
                    return
                }
                
                if let data {
                    do {
                        let result = try JSONDecoder().decode(Movie.self, from: data)
                        observer(.success(result))
                    } catch {
                        observer(.failure(APIError.unknownResponse))
                    }
                } else {
                    observer(.failure(APIError.unknownResponse))
                }
            }
            .resume()
            
            return Disposables.create {
                print("끝!")
            }
        }
        
    }
}
