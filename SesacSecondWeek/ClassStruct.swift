//
//  ClassStruct.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/2/25.
//

import Foundation

class Monster {
    var clothes: String
    let speed: Int
    let power: Int
    let expereience: Int
    
    init(clothes: String, speed: Int, power: Int, expereience: Int) {
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.expereience = expereience
    }
}

struct MonsterStruct {
    let clothes: String
    let speed: Int
    let power: Int
    let expereience: Int
}

class BossMonster: Monster {
    
}

class SuperMonster: BossMonster {
    
}
