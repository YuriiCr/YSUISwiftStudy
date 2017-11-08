//
//  YSContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 15.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

class YSContext {
    
    // MARK: Public properties
    
    var model: Model?
    var user: FBCurrentUser?
    
     // MARK: Public Methods
    
    func execute() {
        self.performEcexution { (state) in
            self.model?.state = state
        }
    }
    
    func cancel() {

    }
    
    func performEcexution(_ block: (ModelState) -> ()) {
        
    }
    
}
