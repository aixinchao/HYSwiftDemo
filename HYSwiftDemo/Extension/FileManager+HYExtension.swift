//
//  FileManager+HYExtension.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/12/9.
//  Copyright © 2020 axc. All rights reserved.
//

import Foundation

extension FileManager {
    private func urlForDirectory(directory: SearchPathDirectory) -> URL? {
        return self.urls(for: directory, in: .userDomainMask).last
    }
    
    private func pathForDirectory(directory: SearchPathDirectory) -> String? {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).first
    }
    
    // Documents文件夹的URL
    var documentsURL: URL? {
        return self.urlForDirectory(directory: .documentDirectory)
    }
    // Documents文件夹的路径
    var documentsPath: String? {
        return self.pathForDirectory(directory: .documentDirectory)
    }
    // Library文件夹的URL
    var libraryURL: URL? {
        return self.urlForDirectory(directory: .libraryDirectory)
    }
    // Library文件夹的路径
    var libraryPath: String? {
        return self.pathForDirectory(directory: .libraryDirectory)
    }
    // Caches文件夹的URL
    var cachesURL: URL? {
        return self.urlForDirectory(directory: .cachesDirectory)
    }
    // Caches文件夹的路径
    var cachesPath: String? {
        return self.pathForDirectory(directory: .cachesDirectory)
    }
    
}
