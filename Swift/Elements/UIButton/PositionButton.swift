//
//  PositionButton.swift
//  SnowMoney
//
//  Created by 30san on 2019/7/15.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

enum TitlePositonEnum {
    case left
    case right
    case top
    case bottom
}

class PositionButton: UIButton {
    /// title占整个按钮比例
    var titleScale: CGFloat = 0.5
    var titlePosition: TitlePositonEnum = .left
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .center
    }
    
    convenience init(_ titlePosition: TitlePositonEnum = .left, _ titleScale: CGFloat = 0.5) {
        self.init()
        self.titleScale = titleScale
        self.titlePosition = titlePosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 去除高亮效果
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = false
        }
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var titleFrame = CGRect.zero
        if titlePosition == .left {
            titleFrame = CGRect(x: 0, y: 0, width: contentRect.size.width * titleScale, height: contentRect.size.height);
        } else if (titlePosition == .right) {
            titleFrame = CGRect(x: contentRect.size.width * (1 - self.titleScale), y: 0, width: contentRect.size.width * self.titleScale, height: contentRect.size.height);
        } else if (titlePosition == .top) {
            titleFrame = CGRect(x: 0, y: 0, width: contentRect.size.width, height: contentRect.size.height * titleScale);
        } else {
            titleFrame = CGRect(x: 0, y: contentRect.size.height * (1 - titleScale), width: contentRect.size.width, height: contentRect.size.height * titleScale);
        }
        return titleFrame
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var imageFrame = CGRect.zero
        if titlePosition == .left {
            imageFrame = CGRect(x: contentRect.size.width * titleScale, y: 0, width: contentRect.size.width * (1 - titleScale), height: contentRect.size.height);
        } else if (titlePosition == .right) {
            imageFrame = CGRect(x: 0, y: 0, width: contentRect.size.width * (1 - titleScale), height: contentRect.size.height);
        } else if (titlePosition == .top) {
            imageFrame = CGRect(x: 0, y: contentRect.size.height * self.titleScale, width: contentRect.size.width, height: contentRect.size.height * (1 - titleScale));
        } else {
            imageFrame = CGRect(x: 0, y: 0, width: contentRect.size.width, height: contentRect.size.height * (1 - titleScale));
        }
        return imageFrame
    }
    
    
}
