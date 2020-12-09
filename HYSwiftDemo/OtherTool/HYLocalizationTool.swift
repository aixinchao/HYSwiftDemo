//
//  HYLocalizationTool.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/11/26.
//  Copyright © 2020 axc. All rights reserved.
//

import Foundation

class HYLocalizationTool {
    
    enum Language: String {
        case auto = "auto"              // 自动，跟随系统
        case english = "en"             // 英文
        case chinese = "zh-Hans"        // 中文
    }
    
    static private let languageUserDefaultKey: String = "languageUserDefaultKey"
    
    class func getLocalizedString(key: String) -> String {
        let currentLanguage = self.getCurrentLanguage()
        
        if currentLanguage != Language.auto {
            let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj")
            let bundle = Bundle.init(path: path!)
            return (bundle?.localizedString(forKey: key, value: nil, table: "Localization"))!
        } else {
            return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        }
    }
    
    class func setLanguage(language: Language) -> Bool {
        let currentLanguage = self.getCurrentLanguage()
        //设置与当前设置相同
        if language == currentLanguage {
            return false
        }
        //如果不同设置新语言
        if language == Language.auto {
            UserDefaults.standard.removeObject(forKey: self.languageUserDefaultKey)
        } else {
            UserDefaults.standard.setValue(language.rawValue, forKey: self.languageUserDefaultKey)
            UserDefaults.standard.synchronize()
        }
        return true
    }
    
    class func getCurrentLanguage() -> Language {
        let languageValue = UserDefaults.standard.object(forKey: self.languageUserDefaultKey) as? String
        
        switch languageValue {
        case Language.auto.rawValue:
            return Language.auto
        case Language.english.rawValue:
            return Language.english
        case Language.chinese.rawValue:
            return Language.chinese
        default:
            return Language.auto
        }
    }
}
