//
//  File.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 02.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

extension Bool {
    static var random:Bool {
        return randomBool()
    }
}

extension Int {
    static var random:Int {
        return Int(arc4random_uniform(UInt32.max))
    }
    
    static func randomNumberToMaxValue(maxValue:Int) -> Int {
        return Int(arc4random_uniform(UInt32(maxValue)))
    }
}

protocol Randoms {
   
}
