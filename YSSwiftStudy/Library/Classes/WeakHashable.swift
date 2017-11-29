//
//  WeakHashable.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 29.11.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

struct WeakHashable<Value: Hashable>: Hashable {
    static func ==(lhs: WeakHashable<Value>, rhs: WeakHashable<Value>) -> Bool {
         return lhs.hashValue == rhs.hashValue
    }
    
//    weak var value: Value?
    weak var value: Model?
    var hashValue: Int
    
    init(value: Model) {
        self.value = value
        self.hashValue = value.hashValue
    }
    
}
