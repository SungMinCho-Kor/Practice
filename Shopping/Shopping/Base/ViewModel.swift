//
//  ViewModel.swift
//  Shopping
//
//  Created by 조성민 on 2/25/25.
//

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
