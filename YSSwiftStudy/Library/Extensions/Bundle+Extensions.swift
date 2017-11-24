//
//  Bundle+Extensions.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 17.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

extension Bundle {
    static func object<T>(ofClass cls: T.Type) -> T? {
        return main.loadNibNamed(toString(type: cls), owner: nil) as? T
    }
}
