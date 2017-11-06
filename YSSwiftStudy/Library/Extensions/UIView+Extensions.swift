//
//  Constants.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 03.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

extension UIView {
    var aurtoresizeAll: UIViewAutoresizing {
        return [.flexibleBottomMargin,
                .flexibleTopMargin,
                .flexibleLeftMargin,
                .flexibleRightMargin,
                .flexibleWidth,
                .flexibleHeight]
    }
}

protocol RootView {
    associatedtype ViewType
    
    var rootView: ViewType? {get}
}

extension RootView where Self: UIViewController {
    var rootView: ViewType? {
        return self.viewIfLoaded as? ViewType
    }
}

