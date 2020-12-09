//
//  HYMacro.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/11/24.
//  Copyright © 2020 axc. All rights reserved.
//

import Foundation
import UIKit

let HYMainColor = UIColor.orange

// 屏幕宽高
let HYScreenWidth = UIScreen.main.bounds.width
let HYScreenHeight = UIScreen.main.bounds.height
// 根据iphone 6/6s 的屏幕比率
let HYScreenWidthRatio = (HYScreenWidth / 375.0)
let HYScreenHeightRatio = (HYScreenHeight / 667.0)

// 状态栏高度
let HYStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
// 导航栏高度
let HYNavBarHeight = (HYStatusBarHeight + 44.0)
// 标签栏高度
let HYTabBarHeight = (isPhoneX() ? 83.0 : 49.0)


func isPhoneX() -> Bool {
    if #available(iOS 11.0, *) {
        if (UIApplication.shared.delegate as? AppDelegate )?.window?.safeAreaInsets.bottom != 0 {
            return true
        }
        return false
    }
    return false
}
