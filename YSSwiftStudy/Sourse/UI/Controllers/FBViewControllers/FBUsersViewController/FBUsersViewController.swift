//
//  FBUsersViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUsersViewController: FBViewController {
    
    // MARK: Public properties
    
    typealias ViewType = FBUserView
    var rootView: FBUsersView?

    override func viewDidLoad() {
        super.viewDidLoad()

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


}
