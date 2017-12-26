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
import RxSwift

class FBLoginContext: YSContext {
    
    // MARK: Public properties
    
    var user: FBCurrentUser? {
        get { return self.model as? FBCurrentUser }
        set {}
    }
    
    var loginSubject = PublishSubject<FBCurrentUser>()
    
    // MARK: Initailization
    
    init(user: FBCurrentUser) {
        super.init(model: user)
        self.user = user
        
    }
    
    convenience init(user: FBCurrentUser, subject: PublishSubject<FBCurrentUser>) {
        self.init(user: user)
        self.user = user
        self.loginSubject = subject
    }
    
    // MARK: Public methods
    
    override func performExecution(_ block: @escaping (ModelState) -> ()) {
        if let user = self.user {
            if user.isAuthorized {
                self.loginSubject.onNext(user)
                return
            }
            
            let loginManager = LoginManager()
            loginManager.logIn([.publicProfile, .userFriends], viewController: nil, completion: { (LoginResult) in
                switch LoginResult {
                    
                case .success(_, _, let token):
                    user.userID = token.userId
                    user.token = token.authenticationToken
                    self.loginSubject.onNext(user)
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
