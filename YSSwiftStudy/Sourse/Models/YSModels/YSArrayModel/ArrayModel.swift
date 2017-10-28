//
//  ArrayModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 27.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ArrayModel: Model {
    
    // MARK: Public Properties
    var array: Array<AnyObject>?
    var count:Int {
        if let array = self.array {
            return array.count
        }
        
        return 0
    }
    
    // MARK: Public Methods
    func addObject(_ object:AnyObject) {
        
    }
    
    func addObjects(_ objects:AnyObject) {
        for object in self.array! {
            self.addObject(object)
        }
    }
}
