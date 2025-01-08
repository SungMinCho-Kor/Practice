//: [Previous](@previous)

import UIKit

protocol Mentor {
    
}

class Jack: Mentor {
    
}

class Hue: Mentor {
    
}

struct Bran: Mentor {
    
}

struct Den: Mentor {
    
}

@objc
protocol ViewPresentableProtocol: AnyObject {
    
    var backgroundColor: UIColor { get }
    var navigationTitleString: String { get set }
    
    func configureNavigationItem()
    func configureView()
    
    //옵셔널 프로토콜
    @objc optional func configureTextField()
}

class SearchViewController: ViewPresentableProtocol {
    
    var name = ""
    
    let backgroundColor: UIColor = .blue
    var navigationTitleString: String {
        get {
            return "안녕하세요"
        }
        set {
            name = newValue
        }
    }
    func configureNavigationItem() {
        <#code#>
    }
    
    func configureView() {
        <#code#>
    }

}
//: [Next](@next)
