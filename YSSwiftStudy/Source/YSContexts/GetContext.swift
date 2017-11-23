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
    
    var graphPath: String?
    var parameters: [String : String]?
    
    var cachedFileName: String?
    
    var user: FBUser? {
        return self.model as? FBUser
    }
    
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
                    model.notifyOfState()
                    if state == .didLoad {
                        return
                    }
                }
                
               model.state = .willLoad
            }
            super.execute()
        }
    }
    
    override func performExecution(_ block: @escaping (ModelState) -> ()) {
        if let graphPath = self.graphPath, let parameters = self.parameters {
            let request = GraphRequest(graphPath: graphPath, parameters: parameters)
            var state = self.user?.state
            request.start {[weak self] (response, request) in
                
                switch request {
                    
                case .success(let response):
                    self?.save(response: (response as AnyObject) as? JSON)
                    self?.parse(response: (response as AnyObject) as? JSON)
                    state = .didLoad
                    
                case .failed(_):
                    if let cachedResponse = self?.cachedResponsePath {
                        self?.parse(response: (cachedResponse as AnyObject) as? JSON)
                        self?.user?.state = .didLoad
                    } else {
                        self?.user?.state = .loadingFailed
                    }
                }
                if let state = state {
                    block(state)
                }
            }
        }
    }
    
    func save(response: JSON?) {
        if let path = self.cachedResponsePath, let response = response {
             NSKeyedArchiver.archiveRootObject(response, toFile: path)
        }
    }
    
    // this methid is intended for subclassing, do not call it directly
    
    func parse(response: JSON?) {
        
    }

}
