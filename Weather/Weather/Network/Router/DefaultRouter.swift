//
//  DefaultRouter.swift
//  Weather
//
//  Created by 조성민 on 2/3/25.
//

import Alamofire
import Foundation

enum DefaultRouter {
    case fetchWeather(
        lat: Double,
        lon: Double
    )
}

extension DefaultRouter: Router {
    var baseURL: String {
        return Environment.baseURL.value
    }
    
    var path: String {
        switch self {
        case .fetchWeather:
            return "/data/2.5/weather"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: [String : String] {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .fetchWeather(let lat, let lon):
            return [
                "lat": lat,
                "lon": lon,
                "appid": Environment.apiKey.value
            ]
        }
    }
    
    var encoding: (any ParameterEncoding)? {
        switch self {
        case .fetchWeather:
            return URLEncoding.default
        }
    }
}
