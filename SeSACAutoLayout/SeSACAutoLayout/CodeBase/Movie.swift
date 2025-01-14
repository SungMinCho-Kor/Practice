//
//  Movie.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 1/13/25.
//

struct MovieResponse: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [Movie]
}

struct Movie: Decodable {
    let rank: String
    let movieNm: String
    let openDt: String
}

//extension Movie {
//    static let mockList: [Movie] = [
//        Movie(
//            rank: "1",
//            movieNm: "엽문4: 더 파이널",
//            openDt: "2020-04-01"
//        ),
//        Movie(
//            rank: "2",
//            movieNm: "주디",
//            openDt: "2020-03-25"
//        ),
//        Movie(
//            rank: "3",
//            movieNm: "1917",
//            openDt: "2020-02-19"
//        ),
//        Movie(
//            rank: "4",
//            movieNm: "인비저블맨",
//            openDt: "2020-02-26"
//        ),
//        Movie(
//            rank: "5",
//            movieNm: "n번째 이별 중",
//            openDt: "2020-04-01"
//        ),
//        Movie(
//            rank: "6",
//            movieNm: "스케어리 스토리:어둠의 속삭임",
//            openDt: "2020-03-25"
//        ),
//        Movie(
//            rank: "7",
//            movieNm: "날씨의 아이",
//            openDt: "2019-10-30"
//        ),
//        Movie(
//            rank: "8",
//            movieNm: "라라랜드",
//            openDt: "2016-12-07"
//        ),
//        Movie(
//            rank: "9",
//            movieNm: "너의 이름은.",
//            openDt: "2017-01-04"
//        ),
//        Movie(
//            rank: "10",
//            movieNm: "다크 워터스",
//            openDt: "2020-03-11"
//        )
//    ]
//}
