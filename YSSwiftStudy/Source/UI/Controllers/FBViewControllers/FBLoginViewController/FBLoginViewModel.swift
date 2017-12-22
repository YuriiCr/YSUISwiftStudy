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
    
    // MARK: Public methods
    
    var bag = DisposeBag()
    var didTapLoginButton = PublishSubject<Void>()
    var user = FBCurrentUser()
    var context: YSContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    func observe() {
        self.didTapLoginButton.asObservable().subscribe  (  onNext: {
            self.context = FBLoginContext(user: self.user)
        }).disposed(by: self.bag)
    }
    
    
}
