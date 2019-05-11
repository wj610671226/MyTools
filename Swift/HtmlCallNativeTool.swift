//
//  HtmlCallNativeTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/4/22.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit
enum HtmlCallNaviveKey: String {
    case CallPhoneKey = "dial"                      // 打电话key
    case JumpAppKey = "jumpStudyApp"                // APP跳转
    case OpenPublicPostsKey = "openPublicPosts"     // 打开日志或者发布帖子页面
}

protocol HtmlCallNativeTool {
    /**
     打电话
     */
    func callPhone(view: UIView, phoneNumber: String)
    
    /**
     跳转到其他APP
     */
    func jumpStudyApp(urlString: String)
    
    /**
     进入发表帖子页面或者日志页面
     
     - parameter userID: 用户ID
     */
    func openPublicPostsViewController(userMessage: String)
}

extension HtmlCallNativeTool where Self: UIViewController {
    
    func callPhone(view: UIView, phoneNumber: String) {
        let webView = UIWebView()
        let string = "tel://" + phoneNumber
        webView.loadRequest(NSURLRequest(URL: NSURL(string: string)!))
        view.addSubview(webView)
    }
    
    func jumpStudyApp(urlString: String) {
        let url = NSURL.init(string: "com.jyzx365.pingchangxian://" + urlString)
        if UIApplication.sharedApplication().canOpenURL(url!) {
            UIApplication.sharedApplication().openURL(url!)
        } else {
            let url = NSURL.init(string: "http://book.jystudy.com:8080/update/pingchangxian/downhtml/download.html")
            UIApplication.sharedApplication().openURL(url!)
        }
    }
    
    func openPublicPostsViewController(userMessage: String) {
//        let publicVC = PublicPostsViewController();
        let publicVC = UIStoryboard.init(name: "PublicPostsViewController", bundle: nil).instantiateViewControllerWithIdentifier("PublicPostsViewController") as! PublicPostsViewController
        publicVC.userMessage = userMessage
        presentViewController(publicVC, animated: true, completion: nil)
    }
}