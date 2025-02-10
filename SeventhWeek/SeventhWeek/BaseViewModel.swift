//
//  BaseViewModel.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/10/25.
//

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
