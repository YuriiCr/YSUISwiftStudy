//
//  FBLoginViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBLoginViewController: FBViewController {
    
    // MARK: RootView
    
    typealias ViewType = FBLoginView
    
    // MARK: Initialization
    
     init() {
        super.init(model: FBCurrentUser())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: IBActions
    
    @IBAction func onLogin(sender: UIButton) {
        self.context = FBLoginContext()
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
