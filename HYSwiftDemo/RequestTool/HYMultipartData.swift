//
//  HYMultipartData.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/12/1.
//  Copyright © 2020 axc. All rights reserved.
//

import Foundation

public enum HYDataMimeType: String {
    case JPG    =   "image/jpg"
    case PNG    =   "image/png"
    case JPEG   =   "image/jpeg"
    case GIF    =   "image/gif"
    case HEIC   =   "image/heic"
    case HEIF   =   "image/heif"
    case WEBP   =   "image/webp"
    case TIF    =   "image/tif"
    case JSON   =   "application/json"
}

public class HYMultipartData {
    // 数据
    let data: Data
    // 名称
    let name: String
    // 文件名
    let fileName: String
    // 数据类型
    let mimeType: String
    
    init(data: Data, name: String, fileName: String, mimeType: String) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
    
    convenience init(data: Data, name: String, fileName: String, type: HYDataMimeType) {
        self.init(data: data, name: name, fileName: fileName, mimeType: type.rawValue)
    }
}
