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
        didSet {
            let controller = self.observationController
            let loadingView = self.rootView?.loadingView
            
            controller?[.didLoad] = { [weak self]
                _, _ in
                self?.fill(with: self?.model)
                loadingView?.state = .hidden
            }
            
            controller?[.didUnload] = { [weak self]
                _, _ in
                self?.dismiss(animated: true)
            }
            
            controller?[.willLoad] = {
                _, _ in
                loadingView?.state = .visible
            }
            
            controller?[.loadingFailed] = {
                _, _ in
                loadingView?.state = .hidden
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
        self.model.map { self.context = GetUserContext(model: $0) }
    }
    
    // MARK: IBAction
    
    @IBAction func onFriends(sender: UIButton) {
        let usersController = FBUsersViewController(model: self.user?.friends, nibName: toString(type: FBUsersViewController.self))
        self.navigationController?.pushViewController(usersController, animated: true)
    }
    
    @IBAction func onlogOut(sender: UIButton) {
        self.logoutContext = FBLogoutContext()
    }
}
