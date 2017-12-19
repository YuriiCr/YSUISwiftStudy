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
        static let userName = "first_name"
        static let userSurname = "last_name"
        static let url = "url"
        static let data = "data"
        static let image = "picture"
    }
    
    // MARK: Public properties
    
    static func fill(user: FBUser, with response: JSON) {
        let images = response[Keys.image] as? JSON
        let data = images?[Keys.data] as? [String : String]
        let name = response[Keys.userName] as? String
        let surname = response[Keys.userSurname] as? String
        let urlString = data?[Keys.url]
        let url = urlString?.asUrl()
        let id = response[Keys.userID] as? String
        
        user.name = name
        user.surname = surname
        user.photoURL = url
        user.userID = id
        user.imageModel = url.flatMap {ImageModel.imageModelWith(url: $0)}
        
    }
    
    // MARK: Public Methods
    
    static func user(with response: JSON) -> FBUser {
        let user = FBUser()
        self.fill(user: user, with: response)
        
        return user
    }
    
}
