//
//  HYNetworkRequest.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/12/1.
//  Copyright © 2020 axc. All rights reserved.
//

import Foundation
import Alamofire

public class HYNetworkRequest: Equatable {
    
    // 网络请求
    var request: Alamofire.Request?
    // 请求成功响应回调
    private var successHandler: HYSuccessHandler?
    // 请求失败响应回调
    private var failuerHandler: HYFailureHandler?
    // 上传或者下载进度响应回调
    private var progressHandler: HYProgressHandler?
    
    // 处理请求响应
    func handleResponse(response: AFDataResponse<Any>) {
        switch response.result {
        case .success(let json):
            if let closure = successHandler {
                closure(json)
            }
        case .failure(let error):
            if let closure = failuerHandler {
                closure(error)
            }
        }
        clearReference()
    }
    
    func downHandleResponse(response: AFDownloadResponse<Any>) {
        switch response.result {
        case .success(let json):
            if let closure = successHandler {
                closure(json)
            }
        case .failure(let error):
            if let closure = failuerHandler {
                closure(error)
            }
        }
        clearReference()
    }
    
    // 处理请求进度
    func handleProgress(progress: Foundation.Progress) {
        if let closure = progressHandler {
            closure(progress)
        }
    }
    
    // 添加请求成功响应回调
    @discardableResult
    public func success(_ closure: @escaping HYSuccessHandler) -> Self {
        successHandler = closure
        return self
    }
    
    // 添加请求失败响应回调
    @discardableResult
    public func failure(_ closure: @escaping HYFailureHandler) -> Self {
        failuerHandler = closure
        return self
    }
    
    // 添加请求失败响应回调
    @discardableResult
    public func progress(closure: @escaping HYProgressHandler) -> Self {
        progressHandler = closure
        return self
    }
    
    // 取消请求
    func cancel() {
        request?.cancel()
    }
    
    // 释放引用
    func clearReference() {
        successHandler = nil
        failuerHandler = nil
        progressHandler = nil
    }
    
    public static func == (lhs: HYNetworkRequest, rhs: HYNetworkRequest) -> Bool {
        return lhs.request?.id == rhs.request?.id
    }
}
