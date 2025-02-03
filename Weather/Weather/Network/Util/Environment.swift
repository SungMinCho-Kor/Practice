//
//  Environment.swift
//  Weather
//
//  Created by 조성민 on 2/3/25.
//



import Foundation

enum Environment {
    case baseURL
    case apiKey
    
    var value: String {
        switch self {
        case .baseURL:
            return Bundle.main.infoDictionary?["BASE_URL"] as! String
        case .apiKey:
            return Bundle.main.infoDictionary?["API_KEY"] as! String
        }
    }
}
