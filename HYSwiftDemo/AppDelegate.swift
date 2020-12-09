//
//  AppDelegate.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/11/24.
//  Copyright © 2020 axc. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var tabBar: HYBaseTabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = createRootViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

