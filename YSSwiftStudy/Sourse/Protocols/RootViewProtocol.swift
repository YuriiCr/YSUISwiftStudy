//
//  RootViewProtocol.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 13.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

protocol RootView {
    associatedtype ViewType
    
    var rootView: ViewType? { get }
}

extension RootView where Self: UIViewController {
    var rootView: ViewType? {
        return self.viewIfLoaded as? ViewType
    }
}
