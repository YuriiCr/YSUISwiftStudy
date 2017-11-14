//
//  FBResponseParser.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 14.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

class FBResponseParser {
    
    // MARK: Constants
    
    private struct Keys {
        static let userID = "id"
        static let userName = "fisrt_name"
        static let userSurname = "last_name"
        static let userPhoto = "picture.data.url"
        
    }
    
    // MARK: Public properties
    
    var name: String? {
        if let response = self.response as? NSObject {
            return response.value(forKeyPath: Keys.userName) as? String
        }
        
        return nil
    }
    
    var surname: String? {
        if let response = self.response as? NSObject {
            return response.value(forKeyPath: Keys.userSurname) as? String
        }
        
        return nil
    }
    
    var userID: String? {
        if let response = self.response as? NSObject {
            return response.value(forKeyPath: Keys.userID) as? String
        }
        
        return nil
    }
    
    var photoUrl: URL?
    
    var friends = [FBUser]();
    
    // MARK: Private properties
    
    private var response: AnyObject?
    
    // MARK: Initialization
    
    init (response: AnyObject?) {
        self.response = response
    }
    
    
    
    
}
