//
//  AppDelegate.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 15.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

@UIApplicationMain
class YSAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow.windowWithRootViewController(SquareViewController())
        self.window = window
        window.makeKeyAndVisible()
       
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
   
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
    }

}

