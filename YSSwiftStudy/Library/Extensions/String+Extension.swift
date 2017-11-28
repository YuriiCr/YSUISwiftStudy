//
//  StringExtension.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 25.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

extension String {
    
    static let lowerCaseAlphabet = "abcdefghijklmnopqrstuvwxyz"
    static let upperCaseAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    static func randomName() -> String {
        return randomString().capitalized
    }
    
    static func randomString() -> String {
        var result = ""
        let helpArray = Array(lowerCaseAlphabet)
        
        var count = 0
        while count < defaultStringLength {
            let randomIndex = randomNumberTo(maxValue: lowerCaseAlphabet.count)
            let symbol = helpArray[randomIndex]
            result.append(symbol)
            count += 1
        }
        
        return result
    }
}

