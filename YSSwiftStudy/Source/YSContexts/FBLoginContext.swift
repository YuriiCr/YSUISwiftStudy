//
//  FBLoginContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class FBLoginContext: YSContext {
    
    // MARK: Public properties
    
    var user: FBCurrentUser? {
        get { return self.model as? FBCurrentUser }
        set {}
    }
    
    // MARK: Initailization
    
    init(user: FBCurrentUser) {
        super.init(model: user)
        self.user = user
        
    }
    
    // MARK: Public methods
    
    override func performExecution(_ block: @escaping (ModelState) -> ()) {
        if let user = self.user {
            if user.isAuthorized {
                block(.didLoad)
                return
            }
            
            let loginManager = LoginManager()
            loginManager.logIn([.publicProfile, .userFriends], viewController: nil, completion: { (LoginResult) in
                switch LoginResult {
                    
                case .success(_, _, let token):
                    user.userID = token.userId
                    user.token = token.authenticationToken
                    block(.didLoad)
                    
                case .cancelled:
                    print ("user cancelled login")
                    
                case .failed(_):
                    block(.loadingFailed)
                }
            })
        }
    }
    
}
