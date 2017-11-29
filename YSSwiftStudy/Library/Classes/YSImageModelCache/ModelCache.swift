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
    
    private var cache = [URL : ImageModel]()
    
    static let shared = ModelCache()
    
    // MARK: Private methods
    
    private init() {}
    
    // MARK: Public methods
    
    func add(imageModel: ImageModel) {
        synchronized(imageModel) {
            self.cache[imageModel.url] = imageModel
        }
    }
    
    func remove(imageModel: ImageModel) {
        synchronized(imageModel) {
               self.cache.removeValue(forKey: imageModel.url)
        }
    }
    
    func imageModel(with url: URL) -> ImageModel? {
        return self.cache[url]
    }

}
