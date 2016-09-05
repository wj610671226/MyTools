//
//  SingletonAccountTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/3/24.
//  Copyright © 2016年 jhtwl. All rights reserved.
//  保存登录信息的单例

import UIKit

class SingletonAccountTool: NSObject {
    /// 初始化
    static let shareIntance = SingletonAccountTool()
    /// 保存信息模型
    private var loginMessage :LoginModel = LoginModel()
    private override init() {}
    
    /**
     读取登录信息
     */
    func readAccountMessage() -> LoginModel {
        return loginMessage
    }
    
    /**
     保存登录信息
     */
    func saveAccountMessage(message: AnyObject) {
        LoginModel.mj_setupReplacedKeyFromPropertyName { () -> [NSObject : AnyObject]! in
            return ["JSESSIONID": "token"]
        }
        loginMessage = LoginModel.mj_objectWithKeyValues(message)
        
        let cookie = (NSHTTPCookieStorage.sharedHTTPCookieStorage().cookies?.first)!
        
        if let userCookie = loginMessage.userCookie {
            let cook = NSHTTPCookie(properties: [NSHTTPCookieName: "userCookie", NSHTTPCookieValue: userCookie, NSHTTPCookieVersion: cookie.version, NSHTTPCookieDomain: cookie.domain, NSHTTPCookiePath: cookie.path, NSHTTPCookieSecure: cookie.secure])
            
            // 设置cookie
            NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cook!)
            NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cookie)
        }
    }
}
