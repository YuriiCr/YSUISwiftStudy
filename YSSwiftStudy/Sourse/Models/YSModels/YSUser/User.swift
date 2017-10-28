//
//  YSUser.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 18.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class User: Model, NSCoding {
    
    private struct Keys {
        static let YSName:String? = "YSName"
        static let YSSurname:String? = "YSSurname"
    }
    
    // MARK: Public properties
    var name: String?
    var surname: String?
    
    var imageModel: ImageModel? {
        let fileUrl = Bundle.main.url(forResource:"image", withExtension: "jpg")
        
        if let fileUrl = fileUrl {
            return ImageModel(url: fileUrl)
        }
        
        return nil
    }
    var fullName : String? {
        if let name = self.name {
            return self.surname == nil ? name : "\(name)  \(self.surname!)"
        }
        
        return nil
    }
    
    // MARK: Initialization
    override init() {
        self.name = randomName()
        self.surname = randomName()
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey:Keys.YSName!)
        aCoder.encode(self.surname, forKey:Keys.YSSurname!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: Keys.YSName!) as? String
        self.surname = aDecoder.decodeObject(forKey: Keys.YSSurname!) as? String
    }
    
}
