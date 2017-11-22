//
//  FBCurrentUser.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBCurrentUser: FBUser {
    var token: String?
    var isAuthorized: Bool {
        return false
    }

}
