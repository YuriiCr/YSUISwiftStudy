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
        static let parametersFriendsValues = "first_name,last_name,picture{url}"
    }
    
    // MARK: Public properties
    
    override var parameters: [String : String] {
        get {
            return [Constants.parametersFieldName : Constants.parametersFriendsValues]
        }
        set { }
    }
    
    override var graphPath: String { return self.userID + "/friends/"}
    
    override var cachedFileName: String {
        get { return Constants.friendCachedFileName }
        set { }
    }
    
    override var user: FBUser? {
        get { return self._user }
        set {_user = newValue}
    }
    
    // MARK: Private properties
    
    private var _user: FBUser?
    
    private var userID: String { return self.user?.userID ?? ""}
    
    private var friends: UsersModel? {
        return self.model as? UsersModel
    }
    
    // MARK: Initialization
    
    init(model: Model, user: FBUser, currentUser: FBCurrentUser) {
        super.init(model: model, currentUser: currentUser)
        self.user = user
    }
    
    // MARK: Public methods
    
    override func parse(with response: JSON) {
        guard let data = response[Constants.data] as? [JSON] else { return }
        var users = [FBUser]()
        data.forEach {
            users.append(FBResponseParser.user(with: $0))
        }
        let userFriends = self.friends
        userFriends?.performBlockWithoutNotification {
            userFriends?.addObjects(users)
        }
    }
}
