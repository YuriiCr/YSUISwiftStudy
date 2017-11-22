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
    
    // MARK: IBActions
    
    @IBAction func onLogin(sender: UIButton) {
        self.context = FBLoginContext()
    }
    
    // MARK: Public methods
    
    override func fill(with model: Model) {
        self.presentFBUserViewController()
    }
    
    // MARK: Private methods
    
    func presentFBUserViewController() {
        let navigationController = UINavigationController(rootViewController: FBUserViewController(model: self.model))
        self.present(navigationController, animated: true, completion: nil)
    }
    
}
