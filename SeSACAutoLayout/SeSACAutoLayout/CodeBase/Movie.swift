//
//  Movie.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 1/13/25.
//

struct Movie {
    let rank: Int
    let title: String
    let date: String
}

extension Movie {
    static let mockList: [Movie] = [
        Movie(
            rank: 1,
            title: "엽문4: 더 파이널",
            date: "2020-04-01"
        ),
        Movie(
            rank: 2,
            title: "주디",
            date: "2020-03-25"
        ),
        Movie(
            rank: 3,
            title: "1917",
            date: "2020-02-19"
        ),
        Movie(
            rank: 4,
            title: "인비저블맨",
            date: "2020-02-26"
        ),
        Movie(
            rank: 5,
            title: "n번째 이별 중",
            date: "2020-04-01"
        ),
        Movie(
            rank: 6,
            title: "스케어리 스토리:어둠의 속삭임",
            date: "2020-03-25"
        ),
        Movie(
            rank: 7,
            title: "날씨의 아이",
            date: "2019-10-30"
        ),
        Movie(
            rank: 8,
            title: "라라랜드",
            date: "2016-12-07"
        ),
        Movie(
            rank: 9,
            title: "너의 이름은.",
            date: "2017-01-04"
        ),
        Movie(
            rank: 10,
            title: "다크 워터스",
            date: "2020-03-11"
        )
    ]
}
