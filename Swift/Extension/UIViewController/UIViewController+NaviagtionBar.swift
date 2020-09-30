//
//  UIViewController+NaviagtionBar.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/25.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

extension UIViewController {
    /// 设置导航栏风格
    func settingNavigationBarStyle() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor(hex: 0x2E3C4D)//导航栏按钮颜色
            navigationBar.barTintColor = UIColor(hex: 0xF8F8F8)//导航栏背景色
//            self.navigationController?.navigationBar.isTranslucent = false//导航栏不透明
            self.navigationController?.navigationBar.shadowImage = nil
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(hex: 0x2E3C4D),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]//设置导航栏字体颜色,大小
        }
    }
    
    ///  重置导航栏风格
    func resetNavigationBarStyle() {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor(hex: 0x2E3C4D)//导航栏按钮颜色
            navigationBar.barTintColor = UIColor.white//导航栏背景色
            navigationBar.isTranslucent = false//导航栏不透明
            navigationBar.shadowImage = UIImage()//隐藏导航栏底部线条
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(hex: 0x2E3C4D),NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)]//设置导航栏字体颜色,大小
        }
    }
}
