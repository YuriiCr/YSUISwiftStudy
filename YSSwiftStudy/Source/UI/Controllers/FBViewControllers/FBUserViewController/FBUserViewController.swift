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
            
            controller?[.didLoad] = { [weak self, loadingView] _, _ in
                loadingView?.state = .hidden
                self?.rootView?.fillWith(user: self?.user)
            }
            
            controller?[.didUnload] = { [weak self] _, _ in
                self?.dismiss(animated: true)
            }
            
            controller?[.willLoad] = {[weak loadingView]  _, _ in
                loadingView?.state = .visible
            }
            
            controller?[.loadingFailed] = { _, _ in
                loadingView?.state = .hidden
            }
        }
    }
    
    var user: FBUser? { return self.model as? FBUser }
    
    // MARK: Private properties
    
    private var logoutContext:FBLogoutContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    // MARK: Initialization
    
    init(model: Model, currentUser: FBCurrentUser) {
        super.init()
        self.model = model
        self.currentUser = currentUser
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.context = GetUserContext(model: self.model, currentUser: FBCurrentUser()) 
        self.rootView?.loadingView?.state = .hidden
    }
    
    // MARK: IBAction
    
    @IBAction func onFriends(sender: UIButton) {
        guard let user = self.user else { return }
        let usersController = FBUsersViewController(model: UsersModel(), user: user, currentUser: self.currentUser)
        self.navigationController?.pushViewController(usersController, animated: true)
    }
    
    @IBAction func onlogOut(sender: UIButton) {
        (self.model as? FBCurrentUser).map { self.logoutContext = FBLogoutContext(user: $0 ) }
    }
}
