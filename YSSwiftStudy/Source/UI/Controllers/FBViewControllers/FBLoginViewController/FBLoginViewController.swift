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
    
    // MARK: Initialization
    
     init() {
        super.init(model: FBCurrentUser())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    // MARK: IBActions
    
    @IBAction func onLogin(sender: UIButton) {
        if let model = self.model {
            self.context = FBLoginContext(model: model)
        }
        print("touched")
    }
    
    // MARK: Public methods
    
    override func fill(with model: Model?) {
        self.presentFBUserViewController()
    }
    
    // MARK: Private methods
    
    func presentFBUserViewController() {
        let navigationController = UINavigationController(rootViewController: FBUserViewController(model: self.model))
        self.present(navigationController, animated: true, completion: nil)
    }
}
