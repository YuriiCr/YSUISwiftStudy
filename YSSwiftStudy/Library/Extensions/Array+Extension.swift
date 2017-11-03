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
        synchronized(object: self as NSObject) {
            let object = self[index]
            self.remove(at: index)
            self.insert(object, at: destinationIndex)
        }
    }
}
