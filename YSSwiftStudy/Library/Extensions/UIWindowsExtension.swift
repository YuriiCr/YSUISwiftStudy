//
//  UIWindowsExtension.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 25.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

extension UIWindow {
    static func window () -> UIWindow {
        return UIWindow(frame: UIScreen.main.bounds)
    }
    
    static func windowWithRootViewController(_ controller:UIViewController) -> UIWindow {
        let window = self.window()
        window.rootViewController = controller
        return window
    }
}
