//
//  PositionButton.swift
//  OneNet
//
//  Created by 30san on 2020/9/29.
//  Copyright © 2020 westone. All rights reserved.
//

import UIKit

enum TitlePositonEnum {
    case left
    case right
    case top
    case bottom
}

class PositionButton: WstButton {
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

    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = false
        }
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var titleFrame = CGRect.zero
        switch titlePosition {
        case .left:
            titleFrame = CGRect(x: 0, y: 0, width: contentRect.size.width * titleScale, height: contentRect.size.height)
        case .right:
            titleFrame = CGRect(x: contentRect.size.width * (1 - self.titleScale),
                                y: 0,
                                width: contentRect.size.width * self.titleScale,
                                height: contentRect.size.height)
        case .top:
            titleFrame = CGRect(x: 0, y: 0, width: contentRect.size.width, height: contentRect.size.height * titleScale)
        default:
            titleFrame = CGRect(x: 0,
                                y: contentRect.size.height * (1 - titleScale),
                                width: contentRect.size.width,
                                height: contentRect.size.height * titleScale)
        }
        return titleFrame
    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var imageFrame = CGRect.zero
        
        switch titlePosition {
        case .left:
            imageFrame = CGRect(x: contentRect.size.width * titleScale,
                                y: 0,
                                width: contentRect.size.width * (1 - titleScale),
                                height: contentRect.size.height)
        case .right:
            imageFrame = CGRect(x: 0,
                                y: 0,
                                width: contentRect.size.width * (1 - titleScale),
                                height: contentRect.size.height)
        case .top:
            imageFrame = CGRect(x: 0,
                                y: contentRect.size.height * self.titleScale,
                                width: contentRect.size.width,
                                height: contentRect.size.height * (1 - titleScale))
        default:
            imageFrame = CGRect(x: 0,
                                y: 0,
                                width: contentRect.size.width,
                                height: contentRect.size.height * (1 - titleScale))
        }
        return imageFrame
    }
}
