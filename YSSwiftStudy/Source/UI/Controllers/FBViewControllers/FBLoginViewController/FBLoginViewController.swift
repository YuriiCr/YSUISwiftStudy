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
            
            controller?[.didLoad] = { [weak self]
                _, _ in
                self?.fill(with: self?.model)
                loadingView?.state = .hidden
            }
            
            self.observationController?[.didUnload] = { [weak self]
                _, _ in
                self?.dismiss(animated: true)
            }
            
            self.observationController?[.willLoad] = {
                _, _ in
                loadingView?.state = .visible
            }
            
            self.observationController?[.loadingFailed] = {
                _, _ in
                loadingView?.state = .hidden
            }
        }
    }
    
    // MARK: Initialization
    
     init() {
        super.init(model: FBCurrentUser(), nibName: toString(type: FBLoginViewController.self))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    // MARK: IBActions
    
    @IBAction func onLogin(sender: UIButton) {
        if let model = self.model {
            self.context = FBLoginContext(model: model)
        }
    }
    
    // MARK: Public methods
    
    override func fill(with model: Model?) {
        self.presentFBUserViewController()
    }
    
    // MARK: Private methods
    
    func presentFBUserViewController() {
        let navigationController = UINavigationController(rootViewController: FBUserViewController(model: self.model, nibName: toString(type: FBUserViewController.self)))
        self.present(navigationController, animated: true, completion: nil)
    }
}
