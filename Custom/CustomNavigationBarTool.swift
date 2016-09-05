//
//  CustomNavigationBarTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/5/9.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

protocol CustomNavigationBarTool {
    func initCustomNavigationBar(isNeedBackButton: Bool)
    func addRightButton(title: String?, target: AnyObject?, action: Selector)
    func addCloseHtmlButton()
}


extension CustomNavigationBarTool where Self: UIViewController {
    
    var backButton: BackButton {
        let backButton = BackButton(frame: CGRect(x: 0, y: 20, width: 65, height: 44))
        backButton.setImage(UIImage(named: "jt_fh"), forState: .Normal)
        backButton.setTitle("返回", forState: .Normal)
        backButton.addTarget(self, action: #selector(Self.processBackButton), forControlEvents: .TouchDown)
        return backButton
    }
    
    var titleLabel: UILabel {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 44))
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.font = CommonStruct.CommonDataNumber.NAVIGATION_TITLE_FONT
        titleLabel.center.x = CommonStruct.CommonDataNumber.SCREEN_WIDTH / 2
        titleLabel.text = title
        return titleLabel
    }
    
    /**
     设置控制器标题  要在调用此方法之前
     
     - parameter isNeedBackButton: 是否需要默认返回按钮
     */
    func initCustomNavigationBar(isNeedBackButton: Bool) {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: CommonStruct.CommonDataNumber.SCREEN_WIDTH, height: 64))
        backgroundView.backgroundColor = CommonStruct.CommonDataNumber.COMMON_COLOR
        backgroundView.tag = 111
        
        if isNeedBackButton {
            backgroundView.addSubview(backButton)
        }
        
        backgroundView.addSubview(titleLabel)
        view.addSubview(backgroundView)
    }
    
    func addRightButton(title: String?, target: AnyObject?, action: Selector) {
        let rightW: CGFloat = 50
        let rightButton = UIButton(frame: CGRect(x: CommonStruct.CommonDataNumber.SCREEN_WIDTH - rightW, y: 20, width: rightW, height: 44))
        rightButton.addTarget(target, action: action, forControlEvents: .TouchDown)
        rightButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightButton.setTitle(title, forState: .Normal)
        rightButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        backgroundViewAddSubViews(rightButton)
    }
    
    func addCloseHtmlButton() {
        let closeButtonW: CGFloat = 49
        let h: CGFloat = 23
        let y: CGFloat = (44 - h) / 2 + 20
        let closeButton = UIButton(frame: CGRect(x: 50, y: y, width: closeButtonW, height: h))
        closeButton.addTarget(self, action: #selector(Self.processCloseButton), forControlEvents: .TouchDown)
        closeButton.setTitle("关闭", forState: .Normal)
        closeButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        closeButton.setBackgroundImage(UIImage(named: "an.png"), forState: .Normal)
        closeButton.titleLabel?.font = UIFont.systemFontOfSize(17)
        backgroundViewAddSubViews(closeButton)
    }
    
    func initWebViewNavigationBar() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: CommonStruct.CommonDataNumber.SCREEN_WIDTH, height: 64))
        backgroundView.backgroundColor = CommonStruct.CommonDataNumber.COMMON_COLOR
        backgroundView.tag = 111
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 20, width: 44, height: 44))
        backButton.setImage(UIImage(named: "jt_fh"), forState: .Normal)
        backButton.addTarget(self, action: #selector(Self.processBackButton), forControlEvents: .TouchDown)
        backgroundView.addSubview(backButton)
        self.view.addSubview(backgroundView)
        
        backgroundView.addSubview(titleLabel)
        
        addCloseHtmlButton()
    }
    
    func addWebViewRightButton(buttonArray: [UIButton]) {
        let h: CGFloat = 25
        let w: CGFloat = 25
        let y: CGFloat = (44 - h ) / 2 + 20
        let padding: CGFloat = 5
        let x: CGFloat = CommonStruct.CommonDataNumber.SCREEN_WIDTH - w - padding - padding
        
        if buttonArray.isEmpty {
            return
        }
        let count = buttonArray.count - 1
        for index in 0...count {
            let number = count - index
            buttonArray[number].frame = CGRect(x: x - CGFloat(index) * (w + padding), y: y, width: w, height: h)
            backgroundViewAddSubViews(buttonArray[number])
        }
    }
    
    func backgroundViewAddSubViews(view: AnyObject) {
        let backView = self.view.viewWithTag(111)
        backView?.addSubview(view as! UIView)
    }
}


class BackButton: UIButton {
    private let ksale: CGFloat = 0.4
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.contentMode = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRect(x: bounds.size.width * ksale, y: 0, width: bounds.size.width * (1 - ksale), height: bounds.size.height)
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.size.width * ksale, height: bounds.size.height)
    }
}