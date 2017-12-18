//
//  FBUserView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUserView: YSView {
    
     // MARK: Public properties

    @IBOutlet var userImageView: ImageView?
    @IBOutlet var fullNameLabel: UILabel?
    @IBOutlet var friendsButton: UIButton?
    @IBOutlet var logoutButton: UIButton?
    
    // MARK: Public methods
    
    func fillWith(user: FBUser?) {
        self.userImageView?.imageModel = user?.imageModel
        self.fullNameLabel?.text = user?.fullName
    }

}
