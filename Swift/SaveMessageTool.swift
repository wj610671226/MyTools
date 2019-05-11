//
//  SaveMessageTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/4/1.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

protocol SaveMessageTool {
    var def: NSUserDefaults? { get }
    func saveObject(value: AnyObject?, key: String)
    func readObject(key: String) -> AnyObject?
    func removeAllObject()
}

extension SaveMessageTool {
    
    var def: NSUserDefaults? {
        return NSUserDefaults.standardUserDefaults()
    }
    /**
     保存数据
     */
    func saveObject(value: AnyObject?, key: String) {
        def!.setObject(value, forKey: key)
        def!.synchronize()
    }
    
    /**
     读取数据
     */
    func readObject(key: String) -> AnyObject? {
        return def!.objectForKey(key)
    }
    
    /**
     删除所有数据
     */
    func removeAllObject() {
        def!.removeObjectForKey(CommonStruct.SaveLogin.UserKey)
        def!.removeObjectForKey(CommonStruct.SaveLogin.PwdKey)
        def!.synchronize()
    }
}