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
    
    var bag = DisposeBag()
    var didTapLoginButton = PublishSubject<Void>()
    var user = FBCurrentUser()
    var context: YSContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    
    func observeLoginButton() {
        self.loginButton?.rx.tap.bind(to: self.didTapLoginButton).disposed(by: bag)
        self.didTapLoginButton.asObservable().subscribe { (_) in
            self.context = FBLoginContext(user: self.user)
        }
    }

}
