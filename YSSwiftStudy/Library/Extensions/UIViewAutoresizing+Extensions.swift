//
//  UIViewAutoresizing+Extensions.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 25.11.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

extension UIViewAutoresizing {
    static var autoresizeAll: UIViewAutoresizing {
        return [.flexibleBottomMargin,
                .flexibleTopMargin,
                .flexibleLeftMargin,
                .flexibleRightMargin,
                .flexibleWidth,
                .flexibleHeight]
    }
    
    static var autoresizeView: UIViewAutoresizing {
        return [.flexibleWidth, .flexibleHeight]
    }
}
