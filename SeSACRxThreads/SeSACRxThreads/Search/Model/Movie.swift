//
//  Movie.swift
//  SeSACRxThreads
//
//  Created by 조성민 on 2/24/25.
//

struct Movie: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Decodable {
    let movieNm, openDt: String
}
