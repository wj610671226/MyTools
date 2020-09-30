//
//  GlobalViewController.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/11.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

typealias actionBlock = () -> Void

class GlobalViewController: UIAlertController {
    convenience init(title: String, message: String, actionTitle: String, clickAction: @escaping actionBlock) {
        self.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.destructive, handler: {(action) in
            clickAction()
        }))
        self.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.default, handler: nil))
        
        let string = NSMutableAttributedString(string: "删除后无法再找回该文件")
        string.addAttributes([NSAttributedString.Key.foregroundColor : UIColor(hex: 0x8A9199), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)], range: NSRange(location: 0, length: message.count))
        self.setValue(string, forKey: "attributedMessage")
    }
}
