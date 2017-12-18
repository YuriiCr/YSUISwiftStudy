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
        static let parametersFriendValues = "first_name,last_name,picture.height(9999){url}"
    }
    
    // MARK: Public properties
    
    override var parameters: [String : String] {
        get {
           return [Constants.parametersFieldName : Constants.parametersFriendValues]
        }
        set { }
    }
    
    override var graphPath: String {
        get { return self.user?.userID ?? "" }
        set { }
    }
    
    override var cachedFileName: String {
        get { return Constants.friendCachedFileName }
        set { }
    }
    
    override var user: FBUser? {
        get { return self.model as? FBUser }
        set { }
    }
    
    // MARK: Public methods
    
    override func parse(with response: JSON) {
        self.user.map { FBResponseParser.fill(user: $0, with: response) }
    }
    
}
