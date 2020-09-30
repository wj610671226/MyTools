//
//  ErrorHUDTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/4/22.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import SVProgressHUD

protocol HUDTool {
    func showErrorMessage(error: NSError)
}

extension HUDTool {
    func showHUD(status: String, interval: TimeInterval) {
        showHUD(status: status)
        SVProgressHUD.setMinimumDismissTimeInterval(interval)
    }
    
    func showHUD(status: String) {
        SVProgressHUD.showInfo(withStatus: status)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
    }
    
    func showSuccessWithStatus(status: String) {
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    func showErrorWithStatus(status: String) {
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        SVProgressHUD.showError(withStatus: status)
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
