//
//  DebugLogTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/4/22.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

class DebugLogTool: NSObject {
    /**
     自定义log   需要在Build Setting  -->  Other Swift Flags --> Debug 设置 -D DEBUG
     */
    static func debugLog(item: Any) {
        #if DEBUG
            print(item)
        #else
            
        #endif
    }
}


