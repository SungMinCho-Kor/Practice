//
//  Observable.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/4/25.
//

class Observable<T> {
    
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
   func bind(closure: @escaping (T) -> Void) {
       closure(value)
       self.closure = closure
   }
    
   func lazyBind(closure: @escaping (T) -> Void) {
       self.closure = closure
   }
}
