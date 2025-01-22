//
//  Generic.swift
//  FiveWeek
//
//  Created by 조성민 on 1/22/25.
//

import UIKit

// Generic: Type에 유연하게 대응
// Type Parameter: (Type Placeholder) 무슨 타입인지 모르지만 동일한 타입이 들어올 것이라는 걸 알려줌
// Type Constraints: 타입에 제약을 설정한다.
// 함수의 구성에서는 타입을 알 수 없고, 함수를 호출할 때 타입을 결정할 수 있다.
// 런타임 X -> 컴파일 타임에 결정됨
// 매개변수에 타입 어노테이션을 직접 명세해야 컴파일 타임에 무슨 타입인지 확인할 수 있다. 그래서


extension UIViewController {
    func plus(
        a: Int,
        b: Int
    ) -> Int {
        return a + b
    }
    
    func plus(
        a: Double,
        b: Double
    ) -> Double {
        return a + b
    }
    
    func plus(
        a: Float,
        b: Float
    ) -> Float {
        return a + b
    }
    
    func plus<T: Numeric>(
        a: T,
        b: T
    ) -> T {
        let t: String
        return a + b
    }
    
    func plus<T: AdditiveArithmetic>(
        a: T,
        b: T
    ) -> T {
        return a + b
    }
    
    func configureBorder<T: UIView>(view: T) {
        view.layer.cornerRadius = 8
    }
    
    func example<T>(a: @escaping (T) -> Void) -> String {
        return "하이"
    }
}
