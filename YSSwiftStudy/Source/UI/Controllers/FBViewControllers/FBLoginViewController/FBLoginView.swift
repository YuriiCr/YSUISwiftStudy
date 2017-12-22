//
//  FBLoginView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FBLoginView: YSView {

    // MARK: Public properties
    
    @IBOutlet var loginButton: UIButton?
    
    var viewModel = FBLoginViewModel()

    
    func observeLoginButton() {
        self.loginButton?.rx.tap.bind(to: self.viewModel.didTapLoginButton)
        self.viewModel.observe()
}
}
