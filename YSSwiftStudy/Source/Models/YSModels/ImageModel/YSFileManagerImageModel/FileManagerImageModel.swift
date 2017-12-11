//
//  YSFileManagerImageModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 20.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FileManagerImageModel: ImageModel {
    
    // MARK: Public Methods
    
    override func loadImage() -> UIImage? {
//        if self.url.isFileURL {
//            if let data = NSData(contentsOf: self.url) {
//                let image = UIImage(data: data as Data)
//                return image
//            }
//        }
//
//        return nil
        do {
            if self.url.isFileURL {
                let data = try Data.init(contentsOf: self.url)
                
                return UIImage(data: data)
            }
        } catch _ as NSError {
            print ("no image")
        }
        
        
//        return self.url.isFileURL
//            ? Data(contentsOf: self.url).map { UIImage(data: $0) }
//            : nil
        return nil
        
    }
}
