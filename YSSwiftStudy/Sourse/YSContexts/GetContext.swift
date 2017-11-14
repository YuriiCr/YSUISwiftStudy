//
//  GetContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin

class GetContext: YSContext {
    
    // MARK: Public properties
    
    var graphPath = ""
    var parameters = [String : String]()
    var cachedFileName: String?
    
    // MARK: Private properties
    
    private var cachedResponsePath: String? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        if let fileName = self.cachedFileName {
             return documentsPath?.appending(fileName)
        }
        
        return nil
    }
    
    // MARK: Public Methods
    
    override func execute() {
        if let model = self.model {
            synchronized(model) {
                let state = model.state
                if state == .willLoad || state == .didLoad {
                    model.notify(of: state)
                    if state == .didLoad {
                        return
                    }
                }
                
               model.state = .willLoad
            }
            super.execute()
        }
    }
    
    override func performEcexution(_ block: (ModelState) -> ()) {
        let request = GraphRequest(graphPath: self.graphPath, parameters: self.parameters)
        request.start { (response, request) in
            
        }
    }
    
    func save(response: AnyObject) {
        
    }
    
    func parse(response: AnyObject) {
        
    }

}
