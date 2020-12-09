//
//  HYFileManager.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/12/9.
//  Copyright © 2020 axc. All rights reserved.
//

import Foundation

class HYFileManager {
    // 根据key存储信息到NSUserDefults
    class func saveUser(data: AnyObject,key: String) -> Void {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    // 根据key读取NSUserDefults里面的信息
    class func readUserData(key: String) -> AnyObject {
        let obj = UserDefaults.standard.object(forKey: key)
        UserDefaults.standard.synchronize()
        return obj as AnyObject
    }
    // 根据key删除NSUserDefults里面的信息
    class func removeUserData(key: String) -> Void {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    // 根据fileName把对象归档到沙盒里面（Documents文件下）
    class func saveObject(obj: AnyObject,fileName: String) -> Bool {
        var path = self.appendFilePath(fileName: fileName)
        path = path + ".archive"
        return NSKeyedArchiver.archiveRootObject(obj, toFile: path)
    }
    // 根据fileName把沙盒里面的文件解档为对象（Documents文件下）
    class func getObjectByFileName(fileName: String) -> AnyObject {
        var path = self.appendFilePath(fileName: fileName)
        path = path + ".archive"
        return NSKeyedUnarchiver.unarchiveObject(withFile: path) as AnyObject
    }
    // 根据fileName把沙盒里面的文件删除（Documents文件下）
    class func removeObjectByFileName(fileName: String) -> Void {
        var path = self.appendFilePath(fileName: fileName)
        path = path + ".archive"
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {}
    }
    // 根据fileName拼接沙盒Documents文件夹的路径
    class func appendFilePath(fileName: String) -> String {
        let filePath:String = FileManager.default.documentsPath! + "/" + fileName
        if !FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: false, attributes: nil)
            } catch {}
        }
        return filePath
    }
}
