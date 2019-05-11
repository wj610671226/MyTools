//
//  ErrorHUDTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/4/22.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

protocol HUDTool {
    func showErrorMessage(error: NSError)
}

extension HUDTool {
    func showErrorMessage(error: NSError) {
        let message = error.localizedDescription
        let errorMsg = "似乎已断开与互联网的连接"
        let array = message.componentsSeparatedByString(errorMsg)
        if array.count > 1 { // 包含这个字符串
            showErrorWithStatus(errorMsg)
            return
        }
        
        let timeOut = "请求超时"
        let timeOutArray = message.componentsSeparatedByString("The request timed out.")
        if timeOutArray.count > 1 { // 包含这个字符串
            showErrorWithStatus(timeOut)
        }
    }
    
    
    func showHUD(status: String, interval: NSTimeInterval) {
        showHUD(status)
        SVProgressHUD.setMinimumDismissTimeInterval(interval)
    }
    
    func showHUD(status: String) {
        SVProgressHUD.showInfoWithStatus(status)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
    }
    
    func showSuccessWithStatus(status: String) {
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showSuccessWithStatus(status)
    }
    
    func showErrorWithStatus(status: String) {
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showErrorWithStatus(status)
    }
    
    func showHUD(maskType: SVProgressHUDMaskType) {
        showHUD()
        SVProgressHUD.setDefaultMaskType(maskType)
    }
    
    func showHUD() {
        SVProgressHUD.show()
    }
    
    func dismissHUD() {
        SVProgressHUD.dismiss()
    }
}