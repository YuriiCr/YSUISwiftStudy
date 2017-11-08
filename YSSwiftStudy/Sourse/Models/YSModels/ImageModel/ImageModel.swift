//
//  YSImageModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 18.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ImageModel: Model {
    var url:URL
    var image:UIImage?
    
    init(url:URL) {
        self.url = url
    }
    
    deinit {
        let cache = ModelCache.shared
        cache.remove(imageModel: self)
    }
    
    static func imageModelWith(url:URL) -> ImageModel? {
        let cache = ModelCache.shared
        var imageModel = cache.imageModel(with: url)
        if imageModel == nil {
            imageModel = url.isFileURL ? FileManagerImageModel(url: url) : InternetImageModel(url: url)
            if let imageModel = imageModel {
                cache.add(imageModel: imageModel)
                
                return imageModel
            }
        }
        
        return imageModel
    }
    
    func loadImage() -> UIImage? {
        return nil
    }
    
    override func performLoading() {
        self.image = loadImage()
        self.state = self.image == nil ? .modelFailedLoading : .modelDidLoad
    }
}
