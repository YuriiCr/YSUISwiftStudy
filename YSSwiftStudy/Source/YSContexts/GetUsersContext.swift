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
        static let data = "data"
        static let friendCachedFileName = "fbFriends.plist"
        static let parametersFieldName = "fields"
        static let parametersFriendsValues = "friends{first_name,last_name,picture{url}}"
    }
    
    // MARK: Public properties
    
    override var parameters: [String : String] {
        get {
            return [Constants.parametersFieldName : Constants.parametersFriendsValues]
        }
        set { }
    }
    
    override var graphPath: String { return self.user?.userID ?? "" }
    
    override var cachedFileName: String {
        get { return Constants.friendCachedFileName }
        set { }
    }
    
    // MARK: Private properties
    
    private var friends: UsersModel? {
        return self.model as? UsersModel
    }
    
    
    // MARK: Public methods
    
    override func parse(with response: JSON) {
        guard let data = response[Constants.data] as? [JSON] else { return }
        var users = [FBUser]()
        data.forEach {
            users.append(FBResponseParser.user(with: $0))
        }
        self.friends?.addObjects(users)
    }
}


