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
    
    // MARK: Public methods
    func addImageModel(_ imageModel:ImageModel) {
        objc_sync_enter(self)
        self.cache.setObject(imageModel, forKey: imageModel.url as AnyObject)
        objc_sync_exit(self)
    }
    
    func removeImageModel (_ imageModel:ImageModel) {
        objc_sync_enter(self)
        self.cache.removeObject(forKey:imageModel.url as AnyObject)
        objc_sync_exit(self)
    }
    
    func imageModelWithUrl(_ url:URL) -> ImageModel? {
        return self.cache.object(forKey: url as AnyObject)
    }
    
    // MARK: Private methods
    private init() {}
    
}
