import UIKit

protocol JackProtocol: AnyObject {
    func numberOfRowsInSection()
}

class Detail {
    
    weak var delegate: JackProtocol?
    
    func setup() {
        delegate?.numberOfRowsInSection()
    }
    
    init() {
        print("Detail init")
        
    }
    
    deinit {
        print("Detail deinit")
    }
}

class Main: JackProtocol {
    
    func numberOfRowsInSection() {
        print(#function)
    }
    
    lazy var detail = {
        let view = Detail()
        print("detail 클로저 실행")
        view.delegate = self
        return view
    }()
    
    init() {
        print("Main init")
    }
    
    deinit {
        print("Main deinit")
    }
}

var main: Main? = Main()
main?.detail
main = nil
main?.detail


class Person {
    var name: String
    
    lazy var introduce = { [weak self] in
        print("introduce \(self?.name)")
    }
    
    init(name: String) {
        self.name = name
        print("Person init")
    }
    
    deinit {
        print("Person deinit")
    }
    
    func hello() {
        print(#function)
    }
}

//var jack: Person? = Person(name: "Jack")
//jack?.name = "Hue"
//jack?.name
//jack?.hello()
//jack?.introduce()
//let newIntroduce = jack?.introduce
//newIntroduce?()
//
//jack = nil
//
//jack?.name
//jack?.hello()
//jack?.introduce()
//
//newIntroduce?()
