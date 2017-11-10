//
//  FBLoginViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBLoginViewController: FBViewController {
    
    typealias ViewType = FBLoginView
    var rootView: FBLoginView?
    
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
        let userController = FBUsersViewController(coder: NSCoder())
        userController?.model = self.model
        if let userController = userController {
            let navigationController = UINavigationController(rootViewController: userController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
}
