//
//  FBUser.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUser: User {
    
    // MARK: Public properties
    
    var userID: String?
    var photoURL: URL?
    var friends = UsersModel()
    override var imageModel: ImageModel? {
        return self.photoURL.flatMap { ImageModel.imageModelWith(url: $0) }
    }

}
