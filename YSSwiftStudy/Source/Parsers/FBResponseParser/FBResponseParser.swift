//
//  FBResponseParser.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 14.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

class FBResponseParser {
        
    // MARK: Constants
    
    private struct Keys {
        static let userID = "id"
        static let userName = "fisrt_name"
        static let userSurname = "last_name"
        static let url = "url"
        static let data = "data"
        static let image = "picture"
    }
    
    // MARK: Public properties
    
    static func fill(user: FBUser, with response: JSON) {
        let name = response[Keys.userName] as? String
        let surname = response[Keys.userSurname] as? String
        let url = (response[Keys.url] as? String)?.asUrl()
        let id = response[Keys.url] as? String
        
        user.name = name
        user.surname = surname
        user.photoURL = url
        user.userID = id
        user.imageModel = url.flatMap {ImageModel.imageModelWith(url: $0)}
        
    }
    
    static func user(with response: JSON) -> FBUser {
        let user = FBUser()
        self.fill(user: user, with: response)
        
        return user
    }
    
}
