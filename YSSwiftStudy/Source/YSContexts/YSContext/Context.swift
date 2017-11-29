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
    
    init () {
        
    }
    
    convenience init(model: Model) {
        self.init()
        self.model = model
    }
    
    func execute() {
        self.performExecution {[weak self] (state) in
            self?.model?.state = state
        }
    }
    
    func cancel() {

    }
    
    func performExecution(_ block: @escaping (ModelState) -> ()) {
        
    }
    
}
