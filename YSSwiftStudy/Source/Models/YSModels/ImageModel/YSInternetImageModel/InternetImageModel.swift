//
//  YSInternetImageModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 20.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class InternetImageModel: FileManagerImageModel {
    
    private struct Constants {
        static let DirectoryComponent = "images"
    }
    
    // MARK: Private Properties
    
    private var session: URLSession {
        return URLSession.shared
    }
    
    private var task: URLSessionDownloadTask? {
        willSet { newValue?.resume() }
        didSet  { oldValue?.cancel() }
    }
   
    private var imagePath:String? {
        return FileManager.pathWithNameFolder(Constants.DirectoryComponent)
    }
    
    // MARK: Public Methods
    
    override func loadImage() -> UIImage? {
        if let imagePath = self.imagePath {
            if FileManager.default.fileExists(atPath: imagePath) {
                let image = super.loadImage()
                return image
            }
        }
        
        self.task = self.session.downloadTask(with: self.url, completionHandler: { (location, response, error) in
            if let location = location, let imagePath = self.imagePath {                
                try? FileManager.default.moveItem(atPath: location.path, toPath: imagePath)
            }
         })
        
        return super.loadImage()
    }
    
}
