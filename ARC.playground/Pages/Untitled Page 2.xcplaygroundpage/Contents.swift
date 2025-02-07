//: [Previous](@previous)

import Foundation

class Guild {
    
    var name: String
    var owner: User?
    
    init(name: String) {
        self.name = name
        print("Guild init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    var nickname: String
    weak var guild: Guild?
    
    init(nickname: String) {
        self.nickname = nickname
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}


var sesac: Guild? = Guild(name: "새싹")
// RC + 1

var character: User? = User(nickname: "미묘한도사")
// RC + 1

sesac?.owner = character
// RC + 1

character?.guild = sesac
// RC + 1

//character = nil
// RC - 1

sesac = nil
// RC - 1


//: [Next](@next)
