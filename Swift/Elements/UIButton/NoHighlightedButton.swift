//
//  NoHighlightedButton.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/20.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

class NoHighlightedButton: UIButton {
    /// 去除高亮效果
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = false
        }
    }
}
