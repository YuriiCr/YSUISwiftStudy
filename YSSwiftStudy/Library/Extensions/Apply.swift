//
//  Optinal+Extensions.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 12.12.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

extension Array {
    func apply<U>(_ block: [(Element) -> U]) -> [U] {
        var result = [U]()
        for f in block {
            for element in self.map(f) {
                result.append(element)
            }
        }
        
        return result
    }
}

extension Optional {
    func apply (f: ((Wrapped) -> ())?) -> ()? {
        return f.flatMap { block in
            self.flatMap { block($0) }
        }
    }
        
//    func apply<U>(_ block: ((Wrapped) -> U)?) -> U? {
//        switch block {
//        case .some(let someF): return self.map(someF)
//        case .none: return nil
//        }
//    }
    
}
