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
        cache.removeImageModel(self)
    }
    
    func imageModelWithUrl(url:URL) -> ImageModel? {
        let cache = ModelCache.shared
        var imageModel = cache.imageModelWithUrl(url)
        if imageModel == nil {
            imageModel = url.isFileURL ? FileManagerImageModel.init(url: url) : InternetImageModel.init(url: url)
            if let imageModel = imageModel {
                cache.addImageModel(imageModel)
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
