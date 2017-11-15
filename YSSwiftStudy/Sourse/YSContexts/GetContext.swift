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
    
    override func performEcexution(_ block: @escaping (ModelState) -> ()) {
        let request = GraphRequest(graphPath: self.graphPath, parameters: self.parameters)
        var state = self.user?.state
        request.start {[weak self] (response, request) in
            
            
            switch request {
                
            case .success(let response):
                self?.save(response: response as AnyObject)
                self?.parse(response: response as AnyObject)
                state = .didLoad
                
            case .failed(_):
                if let cachedResponse = self?.cachedResponsePath {
                    self?.parse(response: cachedResponse as AnyObject)
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
    
    func save(response: AnyObject) {
        if let path = self.cachedResponsePath {
             NSKeyedArchiver.archiveRootObject(response, toFile: path)
        }
    }
    
    // this methid is intended for subclassing, do not call it directly
    
    func parse(response: AnyObject) {
        
    }

}
