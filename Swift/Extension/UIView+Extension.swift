//
//  UIView+Extension.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/3.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

extension UIView {
    
    static func loadNib() -> UIView {
        let name = NSStringFromClass(self).split(separator: ".").last!
        return loadNib(String(name))
    }
    
    static func loadNib(_ nibName: String) -> UIView {
        return loadNib(nibName, Bundle.main)
    }
    
    static func loadNib(_ nibName: String, _ bundle: Bundle) -> UIView {
        return bundle.loadNibNamed(nibName, owner: nil, options: nil)?.first as! UIView
    }
}
