//
//  YSContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 15.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

class YSContext {
    var model: Model?
    
    func execute() {
        self.performEcexution(state:self.model!.state)
    }
    
    func cancel() {

    }
    
    func performEcexution(state: ModelState) {
        
    }
    
}
