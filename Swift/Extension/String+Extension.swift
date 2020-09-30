//
//  String+Extension.swift
//  ToolsDemo
//
//  Created by 30san on 2020/9/29.
//  Copyright © 2020 Dawninest. All rights reserved.
//

import UIKit
import CommonCrypto

extension String {
    /**
     字符串补零操作
     */
    static func addZeroMethod(param: String) -> String {
        guard let number = Int(param) else {
            return param
        }
        assert(number > 0, "参数不能小于零")
        if number < 10 {
            let strNumber = "0" + String(number)
            return strNumber
        }
        return param
    }
    
    /**
     设置指定字符串文字的颜色
     
     - parameter needSetString: 需要设置的文字
     - parameter normalString:  正常显示的文字
     */
    static func setStringColor(needSetString: String, normalString: String, color: UIColor) -> NSMutableAttributedString{
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: needSetString + normalString)
        
        let length = needSetString.count
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : color], range: NSMakeRange(0, length))
        return attributeString
    }
    
    /**
     获取字符串的自适应大小
     
     - parameter fontSize:   字体的大小
     - parameter maxSize:    最大的范围
     - parameter stringName: 字符串
     
     - returns: 大小
     */
    static func stringSizeToFitCustom(fontSize: CGFloat,maxSize: CGSize, stringName: NSString) -> CGSize {
        let size = stringName.boundingRect(with: maxSize, options:[NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin] , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size
        return size
    }
}



