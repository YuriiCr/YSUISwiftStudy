//
//  FBUserViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUserViewController: FBViewController, RootView {
    
    // MARK: RootView
    
    typealias ViewType = FBUserView
    
    // MARK: Public properties
    
    override var observationController: ObservableObject.ObservationController? {
        willSet {
            self.observationController?[.didLoad] = { [weak self]
                _, _ in
                self?.fill(with: self?.model)
                self?.rootView?.loadingView?.state = .hidden
            }
            
            self.observationController?[.didUnload] = { [weak self]
                _, _ in
                self?.dismiss(animated: true)
            }
            
            self.observationController?[.willLoad] = { [weak self]
                _, _ in
                self?.rootView?.loadingView?.state = .visible
            }
            
            self.observationController?[.loadingFailed] = { [weak self]
                _, _ in
                self?.rootView?.loadingView?.state = .hidden
            }
        }
    }
    
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
    
    @IBAction func onlogOut(sender: UIButton) {
        self.logoutContext = FBLogoutContext()
    }
}
