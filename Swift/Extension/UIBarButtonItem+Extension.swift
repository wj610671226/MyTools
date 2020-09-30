//
//  UIBarButtonItem+Extension.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/6.
//  Copyright © 2019 Dawninest. All rights reserved.
//


import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String) {
        self.init(image: UIImage(named: imageName), style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
    
    convenience init(title: String) {
        self.init(title: title, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
    }
}
