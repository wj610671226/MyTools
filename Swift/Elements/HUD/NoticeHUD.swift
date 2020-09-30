//
//  NoticeHUD.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/26.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

struct NoticeHUD {
    static func showSuccess(message: String, time: Int = 2) {
        SwiftNotice.clear()
        SwiftNotice.showNoticeWithText(NoticeType.success, text: message, autoClear: true, autoClearTime: time)
    }
    
    static func showError(message: String, time: Int = 2) {
        SwiftNotice.clear()
        SwiftNotice.showNoticeWithText(NoticeType.error, text: message, autoClear: true, autoClearTime: time)
    }
    
    static func show(message: String, time: Int = 2) {
        SwiftNotice.showText(message, autoClear: true, autoClearTime: time)
    }
    
    static func wait() {
        SwiftNotice.wait()
    }
    
    static func hide() {
        SwiftNotice.clear()
    }
}
