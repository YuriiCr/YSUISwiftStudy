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
        let data = try? Data(contentsOf: self.url)
        
        return data.flatMap { UIImage(data: $0) }
    }
}
