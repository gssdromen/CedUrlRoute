//
//  CedUrlRouter.swift
//  JingJiRen_ESF_iOS
//
//  Created by cedricwu on 3/29/17.
//  Copyright © 2017 Cedric Wu. All rights reserved.
//

import UIKit

struct CedUrlParseResult {
    var scheme = ""
    var host = ""
    var queryItems: [String: String] = [String: String]()
}

class CedUrlRouter {
    static let shared = CedUrlRouter()
    static let scheme = "esf://"

    var routerDict = [String: String]()

    // MARK: - 注册或注销路由

    /// 注册路由
    ///
    /// - Parameters:
    ///   - key: 路由key
    ///   - objType: 路由目标VC的Type
    public func register(key: String, clazz: AnyClass) {
        let objTypeString = NSStringFromClass(clazz)
        routerDict[key] = objTypeString
    }

    /// 从字典注册路由
    ///
    /// - Parameter dict: 字典：key->路由key，value->路由目标VC的Type
    public func registerFromDict(dict: [String: AnyClass]) {
        for (k, v) in dict {
            let objTypeString = NSStringFromClass(v)
            routerDict[k] = objTypeString
        }
    }

    /// 用类的名字注册路由，类的名字要记得带上Namespace
    ///
    /// - Parameters:
    ///   - key: 路由key
    ///   - className: 带Namespace的类的名字
    public func register(key: String, className: String) {
        routerDict[key] = className
    }

    /// 从字典注册路由,用类的名字注册路由，类的名字要记得带上Namespace
    ///
    /// - Parameter dict: 记得带Namespace的类的名字
    public func registerFromDict(dict: [String: String]) {
        for (k, v) in dict {
            routerDict[k] = v
        }
    }

    /// 注销路由
    ///
    /// - Parameter key: 路由key
    /// - Returns: 路由注销是否成功
    public func unregister(key: String) -> Bool {
        if routerDict.keys.contains(key) {
            _ = routerDict.removeValue(forKey: key)
            return true
        }
        return false
    }

    // MARK: - 解析Push的链接
    public func parseUrl(url: String) -> CedUrlParseResult? {
        if let urlComponent = URLComponents(string: url) {
            let scheme = urlComponent.scheme ?? ""
            let host = urlComponent.host ?? ""
            let queryItems: [URLQueryItem]? = urlComponent.queryItems

            var result = CedUrlParseResult()
            result.scheme = scheme
            result.host = host
            if queryItems != nil {
                var dict = [String: String]()
                for item in queryItems! {
                    dict[item.name] = item.value ?? ""
                }
                result.queryItems = dict
            }
            return result
        }
        return nil
    }

    // MARK: - 获得对象
    public func getObjectFor(parseResult: CedUrlParseResult) -> (AnyObject & CedUrlRouterProtocol)? {
        if routerDict.keys.contains(parseResult.host) {
            let objTypeString = routerDict[parseResult.host]!
            if let protocolType = NSClassFromString(objTypeString) as? CedUrlRouterProtocol.Type {
                let obj = protocolType.init(params: parseResult.queryItems)
                if let o = obj as? (AnyObject & CedUrlRouterProtocol) {
                    return o
                }
            }
        }
        return nil
    }
}
