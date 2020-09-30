//
//  CustomNavigationViewController.swift
//  MyProtocal
//
//  Created by jhtwl on 16/8/15.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }
    
    // 设置导航栏
    private func setNavigationBar() {
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.white
        bar.barTintColor = UIColor(red: 213 / 255.0, green: 0 / 255.0, blue: 34 / 255.0, alpha: 1)
        
        // 设置导航栏字体颜色
        bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white
            ,NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
