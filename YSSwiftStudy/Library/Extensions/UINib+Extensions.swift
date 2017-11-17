//
//  UINib+Extensions.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 13.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

extension UINib {
    
    func object<T>(with cls: T, owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> T? {
        return self.instantiate(withOwner: owner, options: options).filter {$0 is T}.first as? T
    }
    
    static func nib<T>(with cls: T, bundle: Bundle? = .main) -> UINib? {
        return UINib(nibName: String(describing: cls), bundle: bundle)
    }
    
    static func object<T>(with cls: T, owner: Any? = nil, options: [AnyHashable : Any]? = nil) -> T?  {
        let nib = self.nib(with: cls)
        
        return nib?.object(with: cls, owner: owner, options: options)
        
    }
}
