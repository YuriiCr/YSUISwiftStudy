//
//  YSUser.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 18.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class User: Model, NSCoding {
    
    // MARK: Keys
    
    private struct Keys {
        static let name:String = "YSName"
        static let surname:String = "YSSurname"
    }
    
    // MARK: Public properties
    
    var name: String?
    var surname: String?
    
    var imageModel: ImageModel? {
        return Bundle.main.url(forResource:"image", withExtension: "jpg").flatMap { ImageModel.imageModelWith(url: $0) }
    }
    
    var fullName : String? {
        return "\(self.name ?? "") \(self.surname ?? "")"
    }
    
    // MARK: Initialization
    
    override init() {
        self.name = randomName()
        self.surname = randomName()
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey:Keys.name)
        aCoder.encode(self.surname, forKey:Keys.surname)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: Keys.name) as? String
        self.surname = aDecoder.decodeObject(forKey: Keys.surname) as? String
    }
    
}
