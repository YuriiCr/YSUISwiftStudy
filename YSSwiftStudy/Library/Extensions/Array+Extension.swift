//
//  Array+Extension.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 03.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

extension Array {
    mutating func moveObject(at index:Int, to destinationIndex: Int) {
        synchronized(self as AnyObject) {
            let object = self[index]
            self.remove(at: index)
            self.insert(object, at: destinationIndex)
        }
    }
}

extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
