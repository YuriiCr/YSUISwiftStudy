//
//  FBLoginViewModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 20.12.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation
import RxSwift

class FBLoginViewModel {
    
    // MARK: Public properties
    
    var bag = DisposeBag()
    var didTapLoginButton = PublishSubject<Void>()
    var didLogin = PublishSubject<FBCurrentUser>()
    var model: FBCurrentUser
    var context: FBLoginContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    // MARK: Initialization
    
    init(model: FBCurrentUser) {
        self.model = model
        self.didTapLoginButton
            .subscribe  (  onNext: {
                self.context = FBLoginContext(user: self.model)
                self.context?.loginSubject = self.didLogin
        })
            .disposed(by: self.bag)
    }

}
