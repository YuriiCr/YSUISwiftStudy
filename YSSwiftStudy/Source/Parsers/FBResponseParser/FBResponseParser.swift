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
        static let userPhoto = "picture.data.url"
        static let userFriends = "friends.data"
    }
    
    // MARK: Public properties
    
    var name: String? {
        if let response = self.response as NSObject? {
            return response.value(forKeyPath: Keys.userName) as? String
        }
        
        return nil
    }
    
    var surname: String? {
        if let response = self.response as NSObject? {
            return response.value(forKeyPath: Keys.userSurname) as? String
        }
        
        return nil
    }
    
    var userID: String? {
        if let response = self.response as NSObject? {
            return response.value(forKeyPath: Keys.userID) as? String
        }
        
        return nil
    }
    
    var photoUrl: URL? {
        if let response = self.response as NSObject? {
            return URL(string: (response.value(forKeyPath: Keys.userPhoto) as! String))
        }
        
        return nil
    }
    
    var friends:[FBUser] {
        if let response = self.response as NSObject? {
            let afriends =  response.value(forKeyPath: Keys.userFriends) as? Array<JSON>
            if let afriends = afriends {
                for friend in afriends {
                    var mutableFriends = [FBUser]()
                    mutableFriends.append(self.userWith(response: friend))
                    
                    return mutableFriends
                }
            }
            
        }
        
        return []
    }
    
    // MARK: Private properties
    
    private var response: JSON?
    
    // MARK: Initialization
    
    init (response: JSON?) {
        self.response = response
    }
    
    // MARK: Private properties
    
    
    private func userWith(response: JSON?) -> FBUser {
        let fbUser = FBUser()
        let parser = FBResponseParser(response: response)
        
        fbUser.userID = parser.userID
        fbUser.name  = parser.name
        fbUser.surname = parser.surname
        fbUser.photoURL = parser.photoUrl
        fbUser.friends.addObjects(parser.friends)
        
        return fbUser
    }
    
}
