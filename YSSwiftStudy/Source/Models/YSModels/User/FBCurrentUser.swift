//
//  FBCurrentUser.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import FacebookCore

class FBCurrentUser: FBUser {
    
    // MARK: Public properties
    
    var token: String?
    var isAuthorized: Bool {
        let token = AccessToken.current?.authenticationToken

        return nil != token
        ? token == self.token
        : false
    }

}
