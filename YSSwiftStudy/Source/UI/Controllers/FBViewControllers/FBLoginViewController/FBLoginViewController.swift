//
//  FBLoginViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBLoginViewController: FBViewController, RootView {
    
    // MARK: RootView
    
    typealias ViewType = FBLoginView
    
    // MARK: Public properties
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            let controller = self.observationController
            let loadingView = self.rootView?.loadingView
            
            controller?[.didLoad] = { [weak self, weak loadingView] _, _ in
                loadingView?.state = .hidden
                self?.showViewController()
   
            }
            
            controller?[.didUnload] = { [weak self] _, _ in
                self?.dismiss(animated: true)
            }

            controller?[.willLoad] = { [weak loadingView] _, _ in
                loadingView?.state = .visible
            }
            
            controller?[.loadingFailed] = { [weak loadingView] _, _ in
                loadingView?.state = .hidden
            }
        }
    }
    
    // MARK: Initialization
    
    init(model: Model) {
        super.init()
        self.model = model
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.loadingView?.state = .hidden
        self.rootView?.observeLoginButton()
        self.model = self.rootView?.viewModel.user ?? Model()
    }
   
    // MARK: IBActions
    
    @IBAction func onLogin(sender: UIButton) {
//        (self.model as? FBCurrentUser).map { self.context = FBLoginContext(user: $0) }
    }
    
    // MARK: Public methods
    
    func showViewController() {
        guard let user = self.model as? FBCurrentUser else { return }
        let navigationController = UINavigationController(rootViewController: FBUserViewController(model: user, currentUser: user))
        self.present(navigationController, animated: true, completion: nil)
    }

}
