//
//  Screen.swift
//  CloudDisk
//
//  Created by 30san on 2019/5/27.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

/*
 屏幕操作
 */
class Screen: NSObject {
    
    /// 屏幕宽度尺寸
    public static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// 屏幕高度尺寸
    public static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// 屏幕尺寸
    public static var bounds: CGRect {
        return CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height)
    }

    
    public static var navigationBarHeight: CGFloat {
        return self.isIphoneX ? 88 : 64
    }
    
    public static var stateBarHeight: CGFloat {
        return self.isIphoneX ? 44 : 20
    }
    
    public static var isIphoneX: Bool {
        return self.height >= 812
    }
    
    public static var safeBottomH: CGFloat {
        return self.isIphoneX ? 34 : 0
    }
    
    public static var tabBarH: CGFloat {
        return self.isIphoneX ? 34 + 44 : 44
    }
}
