//
//  FBUserView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FBUserView: YSView {
    
     // MARK: Public properties

    @IBOutlet var userImageView: ImageView?
    @IBOutlet var fullNameLabel: UILabel?
    @IBOutlet var friendsButton: UIButton?
    @IBOutlet var logoutButton: UIButton?
    
    var viewModel = FBUserViewModel()
    private var bag = DisposeBag()
    
    // MARK: Public methods
    
    func fillWith(user: FBUser?) {
        self.userImageView?.imageModel = user?.imageModel
        self.fullNameLabel?.text = user?.fullName
    }
    
    func observeLogOutButton(with user: FBCurrentUser) {
        let model = self.viewModel
        
        self.logoutButton?.rx.tap.bind(to: model.didTapLogOutButton).disposed(by: self.bag)
        model.observe(with: user)
    }

}
