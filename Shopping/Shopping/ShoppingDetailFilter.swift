//
//  ShoppingDetailFilter.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

enum ShoppingDetailFilter: Int, CaseIterable {
    case accuracy
    case date
    case highPrice
    case lowPrice
    
    var buttonTitle: String {
        switch self {
        case .accuracy:
            return "정확도"
        case .date:
            return "날짜순"
        case .highPrice:
            return "가격높은순"
        case .lowPrice:
            return "가격낮은순"
        }
    }
    
    var query: String {
        switch self {
        case .accuracy:
            return "sim"
        case .date:
            return "date"
        case .highPrice:
            return "dsc"
        case .lowPrice:
            return "asc"
        }
    }
}
