//
//  GetContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class GetContext: YSContext {
    
    // MARK: Public properties
    
    var graphPath: String?
    var parameters = Dictionary<String, String>()
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
        
    }

}
