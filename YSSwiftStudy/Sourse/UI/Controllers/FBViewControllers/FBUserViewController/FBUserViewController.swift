//
//  FBUserViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUserViewController: FBViewController {
    
    // MARK: Public properties
    
    typealias ViewType = FBUserView
    var rootView: FBUserView?
   
    
    var user: FBUser? {
        return self.model as? FBUser
    }
    
    // MARK: Private properties
    
    private var logoutContext:FBLogoutContext? {
        willSet {
            newValue?.execute()
        }
        
        didSet {
            oldValue?.cancel()
        }
    }
    
    // MARK: Public methods
    
    override func fill(with model: Model) {
        self.rootView?.fillWith(user: model as! FBUser)
    }
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let selfModel = self.model {
            self.context = GetUserContext(model: selfModel)
        }
    }
    
    // MARK: IBAction
    
    @IBAction func onFriends(sender: UIButton) {
        let usersController = FBUsersViewController(coder: NSCoder())
        usersController?.model = self.user?.friends
        if let usersController = usersController {
             self.navigationController?.pushViewController(usersController, animated: true)
        }
    }
    
    @IBAction func logOut(sender: UIButton) {
        self.logoutContext = FBLogoutContext()
    }

}
