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
    var didLogin = PublishSubject<Void>()
    var model = Model()
    var context: YSContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    // MARK: Initialization
    
    init(model: Model) {
        self.model = model
        self.didTapLoginButton
            .subscribe  (  onNext: {
            (self.model as? FBCurrentUser)
            .map { self.context = FBLoginContext(user: $0) }
        })
            .disposed(by: self.bag)
    }

}
