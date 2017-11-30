//
//  WeakHashable.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 29.11.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

//struct WeakHashable<Value: Hashable>: Hashable {
//
//    var hashValue: Int
//
//    weak var value: Value?
//
//    init(value: Value) {
//        self.value = value
//        self.hashValue = value.hashValue
//    }
//
//    static func ==(lhs: WeakHashable<Value>, rhs: WeakHashable<Value>) -> Bool {
//        return lhs.hashValue == rhs.hashValue
//    }
//}

struct WeakHashable: Hashable {
    
    var hashValue: Int
    
    weak var value: ImageModel?
    
    init(value: ImageModel) {
        self.value = value
        self.hashValue = value.hashValue
    }
    
    static func ==(lhs: WeakHashable, rhs: WeakHashable) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
