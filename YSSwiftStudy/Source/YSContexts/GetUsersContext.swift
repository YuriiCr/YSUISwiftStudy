//
//  GetUsersContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import FacebookCore

class GetUsersContext: GetContext {
    
    // MARK: Constants
    
    private struct Constants {
        static let friendCachedFileName = "fbFriends.plist"
        static let parametersFieldName = "fields"
        static let parametersFriendsValues = "friends{first_name,last_name,id,picture}"
    }
    
    // MARK: Public properties
    
    override var parameters: [String : String]? {
        get {
            return [Constants.parametersFieldName : Constants.parametersFriendsValues]
        }
        
        set { }
    }
    
    override var graphPath: String? {
        get { return AccessToken.current?.userId }
        
        set { }
    }
    
    override var cachedFileName: String? {
        get { return Constants.friendCachedFileName }
        
        set { }
    }
    
    // MARK: Public methods
    
    override func parse(response: JSON?) {
        let parser = FBResponseParser(response: response)
        let users = self.model as? UsersModel
        users?.performBlockWithoutNotification {
            users?.addObjects(parser.friends)
        }
    }

}
