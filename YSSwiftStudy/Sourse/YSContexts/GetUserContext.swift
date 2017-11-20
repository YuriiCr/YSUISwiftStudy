//
//  GetUserContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class GetUserContext: GetContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let friendCachedFileName = "fbFriend.plist"
        static let parametersFieldName = "fields"
        static let parametersFriendValues = "first_name,last_name,picture.type(large)"
    }
    
    // MARK: Public properties
    
    override var parameters: [String : String]? {
        get {
           return [Constants.parametersFieldName : Constants.parametersFriendValues]
        }
       
        set { }
    }
    
    override var graphPath: String? {
        get { return self.user?.userID }
        
        set { }
    }
    
    override var cachedFileName: String? {
        get { return Constants.friendCachedFileName }
        
        set { }
    }
    
    // MARK: Public methods
    
    override func parse(response: AnyObject) {
        let user = self.user
        let parser = FBResponseParser.init(response: response)
        
        user?.userID = parser.userID
        user?.name = parser.name
        user?.surname = parser.surname
        user?.photoURL = parser.photoUrl
    }
    
}
