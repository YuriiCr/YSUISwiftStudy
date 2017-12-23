//
//  FBUserViewModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 22.12.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class FBUserViewModel {
    
        // MARK: Public properties
    
    var bag = DisposeBag()
    var didTapLogOutButton = PublishSubject<Void>()
    
    var context: YSContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    // MARK: Public methods
    
    func observe(with user: FBCurrentUser) {
        self.didTapLogOutButton.subscribe  (  onNext: {
            self.context = FBLogoutContext(user: user)
        }).disposed(by: self.bag)
    }
    
}
    
