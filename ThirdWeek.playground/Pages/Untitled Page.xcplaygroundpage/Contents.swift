import UIKit

class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

var jack = User(name: "mentor")
var bran = jack

jack.name = "jack"

print(jack.name, bran.name)
