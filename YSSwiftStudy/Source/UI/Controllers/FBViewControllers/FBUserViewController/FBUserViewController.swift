//
//  FBUserViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUserViewController: FBViewController {
    
    // MARK: RootView
    
    var rootView: FBUserView?
    
    // MARK: Public properties
    
    typealias ViewType = FBUserView
    
    var user: FBUser? {
        return self.model as? FBUser
    }
    
    // MARK: Private properties
    
    private var logoutContext:FBLogoutContext? {
        willSet { newValue?.execute() }
        
        didSet { oldValue?.cancel() }
    }
    
    // MARK: Public methods
    
    override func fill(with model: Model?) {
        if let user = model as? FBUser {
            self.rootView?.fillWith(user: user)
        }
    }
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = self.model {
            self.context = GetUserContext(model: model)
        }
    }
    
    // MARK: IBAction
    
    @IBAction func onFriends(sender: UIButton) {
        let usersController = FBUsersViewController(model: self.user?.friends)
        self.navigationController?.pushViewController(usersController, animated: true)
    }
    
    @IBAction func logOut(sender: UIButton) {
        self.logoutContext = FBLogoutContext()
    }
}
