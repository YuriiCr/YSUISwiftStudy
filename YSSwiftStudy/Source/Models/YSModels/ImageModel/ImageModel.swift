//
//  YSImageModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 18.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ImageModel: Model {
    
    // MARK: Public properties
    
    var url: URL
    var image: UIImage?
    
    // MARK: Initialization
    
    init(url:URL) {
        self.url = url
    }
    
    deinit {
        ModelCache.shared.remove(imageModel: self)
    }
    
    // MARK: Public methods
    
    static func imageModelWith(url:URL) -> ImageModel? {
        let cache = ModelCache.shared
        var imageModel = cache.imageModel(with: url)
        if imageModel == nil {
            imageModel = url.isFileURL ? FileManagerImageModel(url: url) : InternetImageModel(url: url)
           imageModel.map { cache.add(imageModel: $0) }
            
           return imageModel
        }
        
        return imageModel
    }
    
    func loadImage() -> UIImage? {
        return nil
    }
    
    override func performLoading() {
        self.image = loadImage()
        DispatchQueue.main.async {
                self.state = self.image == nil ? .loadingFailed : .didLoad
        }
    }
}
