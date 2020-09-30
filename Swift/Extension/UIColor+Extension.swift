//
//  UIColor+Extension.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/3.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1)
    }
    
    convenience init(hex: uint) {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16), green: CGFloat((hex & 0xFF00) >> 8), blue: CGFloat(hex & 0xFF))
    }
    
    static func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)), green: CGFloat(arc4random_uniform(256)), blue: CGFloat(arc4random_uniform(256)))
    }
}
