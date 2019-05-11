//
//  WJCustomButton.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/3/16.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

class WJCustomButton: UIButton {

    // 去除高亮效果
    override var highlighted: Bool {
        didSet {
            super.highlighted = false
        }
    }
}
