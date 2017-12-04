//
//  WeakHashable.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 29.11.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

struct WeakHashable<Value: AnyObject & Hashable>: Hashable {
   
    var hashValue: Int

    weak var value: Value?

    init(value: Value) {
        self.value = value
        self.hashValue = value.hashValue
    }
    
    static func ==(lhs: WeakHashable, rhs: WeakHashable) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
