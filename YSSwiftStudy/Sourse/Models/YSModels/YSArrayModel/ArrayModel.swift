//
//  ArrayModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 27.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ArrayModel<T> : Model {
    
    // MARK: Public Properties
    
    private var array: Array<T> = []
    
    var count:Int {
       return self.array.count
    }
    
    // MARK: Public Methods
    func add(_ object: T) {
        
    }
    
    func addObjects(_ objects: T) {
       
    }

    
}
