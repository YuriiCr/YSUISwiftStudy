//
//  YSModelCache.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 20.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ModelCache {
    // MARK: Public properties
    
    var cache = NSMapTable<AnyObject, ImageModel>.strongToWeakObjects()
    static let shared = ModelCache()
    
    // MARK: Private methods
    
    private init() {}
    
    // MARK: Public methods
    
    func add(imageModel: ImageModel) {
        synchronized(object: imageModel) {
            self.cache.setObject(imageModel, forKey: imageModel.url as AnyObject)
        }
    }
    
    func remove(imageModel: ImageModel) {
        synchronized(object: imageModel) {
               self.cache.removeObject(forKey:imageModel.url as AnyObject)
        }
    }
    
    func imageModelWithUrl(_ url: URL) -> ImageModel? {
        return self.cache.object(forKey: url as AnyObject)
    }

}
