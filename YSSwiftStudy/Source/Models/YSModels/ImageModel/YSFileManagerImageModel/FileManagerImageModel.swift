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
        if self.url.isFileURL {
            if let data = NSData(contentsOf: self.url) {
                let image = UIImage(data: data as Data)
                return image
            }
        }
        
        return nil
    }
}
