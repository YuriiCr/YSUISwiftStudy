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
    
     // MARK: Public Methods
    
    func execute() {
        if let model = self.model {
              self.performEcexution(state: model.state)
        }
        
      
    }
    
    func cancel() {

    }
    
    func performEcexution(state: ModelState) {
        
    }
    
}
