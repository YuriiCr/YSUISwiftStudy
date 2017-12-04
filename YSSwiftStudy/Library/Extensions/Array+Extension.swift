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
        objc_sync_enter(self)
        
        let object = self[index]
        self.remove(at: index)
        self.insert(object, at: destinationIndex)
        
        objc_sync_exit(self)
    }
}

extension Array where Element: Equatable {
    
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
        
//        index(of: object).map{ remove(at: $0) }
    }
}
