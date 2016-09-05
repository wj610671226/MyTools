//
//  ParamsSerializationJsonTool.swift
//  PingChangDangJian
//
//  Created by jhtwl on 16/7/11.
//  Copyright © 2016年 jhtwl. All rights reserved.
//  把参数转化为JOSN格式的字符串

import UIKit

protocol ParamsSerializationJsonTool {
    /**
     把参数转化为JOSN格式的字符串
     
     - parameter param: 参数
     
     - returns: JSON格式的字符串
     */
    func paramsSerializationJson(param: AnyObject) -> String
}


extension ParamsSerializationJsonTool {
    // 把参数转化为JOSN格式的字符串
    func paramsSerializationJson(param: AnyObject) -> String {
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(param, options: NSJSONWritingOptions.PrettyPrinted)
            let paramString = String.init(data: data, encoding: NSUTF8StringEncoding)
            return paramString!
        } catch let error {
            print("paramsSerializationJson --> error = \(error)")
            return ""
        }
    }
}