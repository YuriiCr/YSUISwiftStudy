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
    
    var graphPath: String { return "" }
    var parameters: [String : String] { return [:] }
    
    var cachedFileName = ""
    
    var user: FBUser?
    var currentUser: FBCurrentUser
    
    // MARK: Initalization
    
    init(model: Model, currentUser: FBCurrentUser) {
        self.currentUser = currentUser
        
        super.init(model: model)
    }
    
    // MARK: Private properties
    
    private var cachedResponsePath: String? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        

        return  documentsPath?.appending(self.cachedFileName)
        
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
    
        let request = GraphRequest(graphPath: self.graphPath, parameters: self.parameters)
        request.start {[weak self] (response, request) in
                switch request {
                case .success(let response):
                    response.dictionaryValue.map {
                        self?.save(response: $0)
                        self?.parse(with: $0)
                        block(.didLoad)
                    }

                case .failed(_):
                    self?.loadResponse().map {
                        self?.parse(with: $0)
                        block(.didLoad)
                    }
                }
            
            }
    }
    
    func save(response: JSON) {
        _ = self.cachedResponsePath.map {  NSKeyedArchiver.archiveRootObject(response, toFile: $0) }
    }
    
    func loadResponse() -> JSON? {
        return  self.cachedResponsePath.flatMap {  NSKeyedUnarchiver.unarchiveObject(withFile: $0) as? JSON}
    }
    
    // this method is intended for subclassing, do not call it directly
    
    func parse(with response: JSON) {
        
    }

}
