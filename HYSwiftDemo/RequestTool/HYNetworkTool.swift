//
//  HYNetworkTool.swift
//  HYSwiftDemo
//
//  Created by axc on 2020/12/1.
//  Copyright © 2020 axc. All rights reserved.
//

import Foundation
import Alamofire

// 请求成功执行的闭包
public typealias HYSuccessHandler = (_ json: Any) -> Void
// 请求失败执行的闭包
public typealias HYFailureHandler = (_ error: Error) -> Void
// 监听上传或下载进度请求时执行的闭包
public typealias HYProgressHandler = (_ progress: Progress) -> Void

public enum HYReachabilityStatus {
    // 不确定网络是否可访问
    case unknown
    // 网络不可访问
    case notReachable
    // 以太网或WiFi
    case ethernetOrWiFi
    // 蜂窝
    case cellular
}

// 快速获取网络请求主类单例对象
public let HYNetTool = HYNetworkTool.shared
// 监听网络状态通知
public let kNetworkStatusNotification = NSNotification.Name("HYNetworkStatusNotification")

// 网络请求主类
public class HYNetworkTool {
    // 网络请求主类单例对象
    public static let shared = HYNetworkTool()
    // 请求任务数组
    private(set) var taskQueue = [HYNetworkRequest]()
    // Session
    var sessionManager: Alamofire.Session!
    // 网络监听管理对象
    var reachability: NetworkReachabilityManager?
    // 网络状态
    var networkStatus: HYReachabilityStatus = .unknown
    
    private init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 10
        config.timeoutIntervalForResource = 30
        sessionManager = Alamofire.Session(configuration: config)
    }
    
    // get 请求
    public func get(url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, encoding: ParameterEncoding = URLEncoding.default) -> HYNetworkRequest {
        let task = HYNetworkRequest()
        
        var h: HTTPHeaders?
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }
        
        print("请求URL:\(url)\n请求参数:\(parameters as Any)")
        
        task.request = sessionManager.request(url, method: .get, parameters: parameters, encoding: encoding, headers: h).validate().responseJSON { [weak self] response in
            task.handleResponse(response: response)
            if let index = self?.taskQueue.firstIndex(of: task) {
                self?.taskQueue.remove(at: index)
            }
        }
        taskQueue.append(task)
        
        return task
    }
    
    // post 请求
    public func post(url: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, encoding: ParameterEncoding = URLEncoding.default) -> HYNetworkRequest {
        let task = HYNetworkRequest()
        
        var h: HTTPHeaders?
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }
        
        print("请求URL:\(url)\n请求参数:\(parameters as Any)")
        
        task.request = sessionManager.request(url, method: .post, parameters: parameters, encoding: encoding, headers: h).validate().responseJSON { [weak self] response in
            task.handleResponse(response: response)
            if let index = self?.taskQueue.firstIndex(of: task) {
                self?.taskQueue.remove(at: index)
            }
        }
        taskQueue.append(task)
        
        return task
    }
    
    // 上传请求
    public func upload(url: String, parameters: [String: String]?, datas: [HYMultipartData], headers: [String: String]? = nil) -> HYNetworkRequest {
        let task = HYNetworkRequest()

        var h: HTTPHeaders?
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }
        
        print("请求URL:\(url)\n请求参数:\(parameters as Any)")

        task.request = sessionManager.upload(multipartFormData: { (multipartData) in
            // 1.参数 parameters
            if let parameters = parameters {
                for p in parameters {
                    multipartData.append(p.value.data(using: .utf8)!, withName: p.key)
                }
            }
            // 2.数据 datas
            for d in datas {
                multipartData.append(d.data, withName: d.name, fileName: d.fileName, mimeType: d.mimeType)
            }
        }, to: url, method: .post, headers: h).uploadProgress(queue: .main, closure: { (progress) in
            task.handleProgress(progress: progress)
        }).validate().responseJSON(completionHandler: { [weak self] response in
            task.handleResponse(response: response)

            if let index = self?.taskQueue.firstIndex(of: task) {
                self?.taskQueue.remove(at: index)
            }
        })
        taskQueue.append(task)
        return task
    }
    
    // 下载请求
    public func download(url: String, method: HTTPMethod = .post, headers: [String: String]? = nil, destination: DownloadRequest.Destination? = nil) -> HYNetworkRequest {
        let task = HYNetworkRequest()

        var h: HTTPHeaders?
        if let tempHeaders = headers {
            h = HTTPHeaders(tempHeaders)
        }
        
        print("请求URL:\(url)")
        
        task.request = sessionManager.download(url, method: .get, headers: h, to:destination).downloadProgress(queue: .main, closure: { (progress) in
            task.handleProgress(progress: progress)
        }).validate().responseJSON(completionHandler: { [weak self] (response) in
            task.downHandleResponse(response: response)
             
             if let index = self?.taskQueue.firstIndex(of: task) {
                 self?.taskQueue.remove(at: index)
             }
        })
        taskQueue.append(task)
        return task
    }
    
    // 取消所有请求
    public func cancelAllRequests(completingOnQueue queue: DispatchQueue = .main, completion: (() -> Void)? = nil) {
        sessionManager.cancelAllRequests(completingOnQueue: queue, completion: completion)
    }
}

extension HYNetworkTool {
    public func startMonitoring() {
        if reachability == nil {
            reachability = NetworkReachabilityManager.default
        }

        reachability?.startListening(onQueue: .main, onUpdatePerforming: { [unowned self] (status) in
            switch status {
            case .notReachable:
                self.networkStatus = .notReachable
            case .unknown:
                self.networkStatus = .unknown
            case .reachable(.ethernetOrWiFi):
                self.networkStatus = .ethernetOrWiFi
            case .reachable(.cellular):
                self.networkStatus = .cellular
            }
            NotificationCenter.default.post(name: kNetworkStatusNotification, object: nil)
        })
    }
    
    public func stopMonitoring() {
        guard reachability != nil else { return }
        reachability?.stopListening()
    }
}
