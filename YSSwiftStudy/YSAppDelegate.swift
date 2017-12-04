//
//  AppDelegate.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 15.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare

@UIApplicationMain
class YSAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.window {
            $0.rootViewController = SquareViewController()
//            $0.rootViewController = FBLoginViewController()
            $0.makeKeyAndVisible()
        }
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
       
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return SDKApplicationDelegate.shared.application(application, open: url, options: annotation as! [UIApplicationOpenURLOptionsKey : Any])
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

