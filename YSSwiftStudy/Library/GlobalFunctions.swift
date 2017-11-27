//
//  YSRandomString.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 19.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation
import UIKit

// MARK: Constants

let lowerCaseAlphabet = "abcdefghijklmnopqrstuvwxyz"
let upperCaseAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
let defaultStringLength = 7

let autoresizeAll: UIViewAutoresizing = [.flexibleBottomMargin,
                                         .flexibleTopMargin,
                                         .flexibleLeftMargin,
                                         .flexibleRightMargin,
                                         .flexibleWidth,
                                         .flexibleHeight]

// MARK: GLobal functions

func synchronized<T>(_ object: NSObject, block: () -> (T) ) -> T {
    objc_sync_enter(object)
    defer { objc_sync_exit(object) }
    
    return block()
}

func toString<T>(type: T.Type) -> String {
    return String(describing: type)
}

func randomName() -> String {
    var result = ""
    let helpArray = Array(lowerCaseAlphabet)
    
    var count = 0
    while count < defaultStringLength {
        let randomIndex = randomNumberTo(maxValue: lowerCaseAlphabet.count)
        let symbol = helpArray[randomIndex]
        result.append(symbol)
        count += 1
    }
    
    return result.capitalized
}

func randomNumberTo(maxValue:Int) -> Int {
    return Int(arc4random_uniform(UInt32(maxValue)))
}

func randomBool() -> Bool {
    return randomNumberTo(maxValue: 2) == 1
}

func randomObject<T>(object1:T, object2:T) -> T {
    return randomBool() ? object1 : object2
}
