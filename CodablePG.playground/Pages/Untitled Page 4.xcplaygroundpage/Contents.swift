//: [Previous](@previous)

import Foundation

// Struct -> Data -> String -> Server

struct User {
    let name: String
    let age: Int
}

let jack = User(name: "잭", age: 12)

let encoder = JSONEncoder()
//encoder.dateEncodingStrategy
//encoder.keyEncodingStrategy
//encoder.dataEncodingStrategy
//encoder.nonConformingFloatEncodingStrategy


struct SearchQuery {
    
}

//: [Next](@next)
