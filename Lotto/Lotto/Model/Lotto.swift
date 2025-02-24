//
//  Lotto.swift
//  Lotto
//
//  Created by 조성민 on 1/14/25.
//

struct Lotto: Decodable {
    let drwNoDate: String
    let bnusNo: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
}

extension Lotto {
    static let none = Lotto(
        drwNoDate: "",
        bnusNo: 0,
        drwtNo1: 0,
        drwtNo2: 0,
        drwtNo3: 0,
        drwtNo4: 0,
        drwtNo5: 0,
        drwtNo6: 0
    )
}
