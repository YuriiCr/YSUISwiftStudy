//
//  FBUser.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUser: Model {
    
    // MARK: Public properties
    
    var name: String? 
    var surname: String?
    var fullName : String? {
        return [self.name, self.surname].flatMap { $0 }.joined(separator: " ")
    }
    
    var userID: String?
    var photoURL: URL?
    var friends = UsersModel()
    var imageModel: ImageModel? {
        didSet { self.imageModel?.load() }
    }

}
