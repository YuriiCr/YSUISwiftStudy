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
    
    //MARK: Private Properties
    private var session: URLSession {
        return URLSession.shared
    }
    
    private var task: URLSessionDownloadTask? {
        willSet {
            if let task = newValue {
                task.resume()
            }
        }
        
        didSet {
            if let task = oldValue {
                task.cancel()
            }
        }
    }
   
    private var imagePath:String {
        return FileManager.pathWithNameFolder(Constants.DirectoryComponent)
    }
    
    // MARK: Public Methods
    
    override func loadImage() -> UIImage? {
        if FileManager.default.fileExists(atPath: self.imagePath) {
            let image = super.loadImage()
            return image
        }
        
        self.task = self.session.downloadTask(with: self.url, completionHandler: { (location, response, error) in
            if let location = location {
                do {
                    try FileManager.default.moveItem(atPath: location.path, toPath: self.imagePath)
                } catch _ as NSError {

                }
            }
         })
        
        return super.loadImage()
    }
    
    
}
