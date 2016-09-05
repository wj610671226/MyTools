//
//  CheckAccountTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/3/24.
//  Copyright © 2016年 jhtwl. All rights reserved.
//  检查用户是否登录

import UIKit

protocol CheckAccountTool {
    /**
     检查用户是否登录
     */
    func checkAccountIsLogin(login:(loginModel: LoginModel) -> Void,loginOut unLogin:() -> Void)
}

extension CheckAccountTool {
    
    func checkAccountIsLogin(login:(loginModel: LoginModel) -> Void,loginOut unLogin:() -> Void) {
        let loginModel = SingletonAccountTool.shareIntance.readAccountMessage()
        if let alreadyLogin = loginModel.JSESSIONID {
            DebugLogTool.debugLog("alreadyLogin = \(alreadyLogin)")
            login(loginModel: loginModel)
        } else {
            unLogin()
        }
    }
}