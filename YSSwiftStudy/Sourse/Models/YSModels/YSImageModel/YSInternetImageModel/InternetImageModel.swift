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
    
    private var _task: URLSessionDownloadTask?
    
    private var task: URLSessionDownloadTask? {
        get {
            return _task
        } set {
            if _task != newValue {
                if let task = _task {
                    task.cancel()
                }
                
                _task = newValue
                if let task = _task {
                    task.resume()
                }
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
