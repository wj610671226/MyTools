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
    func paramsSerializationJson(param: Any) -> String
}


extension ParamsSerializationJsonTool {
    // 把参数转化为JOSN格式的字符串
    func paramsSerializationJson(param: Any) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
            let paramString = String.init(data: data, encoding: String.Encoding.utf8)
            return paramString!
        } catch let error {
            print("paramsSerializationJson --> error = \(error)")
            return ""
        }
    }
}
