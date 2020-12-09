//
//  AppDelegate+HYExtensions.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/11/25.
//  Copyright © 2020 axc. All rights reserved.
//

import Foundation
import UIKit

extension AppDelegate {
    func createRootViewController() -> HYBaseTabBarController {
        self.tabBar = HYBaseTabBarController()
        self.tabBar?.tabBar.tintColor = HYMainColor
        let childItemsArray = [
                                [
                                    HYClassKey : "HYHomeViewController",
                                    HYTitleKey : HYLocalizationTool.getLocalizedString(key: "首页"),
                                    HYImgKey : "icon_home",
                                    HYSelImgKey : "icon_home",
                                ],
                                [
                                    HYClassKey : "HYMeViewController",
                                    HYTitleKey : HYLocalizationTool.getLocalizedString(key: "我的"),
                                    HYImgKey : "icon_wode",
                                    HYSelImgKey : "icon_wode",
                                ]
                              ]
        for item in childItemsArray {
            let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
            let className = NSClassFromString("\(workName).\(item[HYClassKey]!)") as! UIViewController.Type
            let vc = className.init()
            vc.title = item[HYTitleKey]
            let nav = HYBaseNavigationController.init(rootViewController: vc)
            nav.navigationBar.tintColor = HYMainColor
            nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : HYMainColor]
            nav.tabBarItem.title = item[HYTitleKey]
            nav.tabBarItem.image = UIImage.init(named: item[HYImgKey]!)
//            nav.tabBarItem.selectedImage = UIImage.init(named: item[HYImgKey])
            nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : HYMainColor], for: UIControl.State.selected)
            self.tabBar?.addChild(nav)
        }
        
        return self.tabBar!
    }
}
