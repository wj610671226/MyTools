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
        navigationBar.hidden = true
    }
    
    // 设置导航栏
    private func setNavigationBar() {
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.whiteColor()
        bar.barTintColor = UIColor(red: 213 / 255.0, green: 0 / 255.0, blue: 34 / 255.0, alpha: 1)
        
        // 设置导航栏字体颜色
        bar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()
            ,NSFontAttributeName : UIFont.boldSystemFontOfSize(20)]
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        return super.popViewControllerAnimated(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
