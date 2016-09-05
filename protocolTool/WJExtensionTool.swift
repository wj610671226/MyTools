//
//  WJExtensionTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/3/15.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import Foundation

// MARK: - 对颜色的扩展
extension UIColor {
    static func rgbColor(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat) -> UIColor {
        return UIColor(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: 1)
    }
}

extension UIViewController {
    /**
     检查网络状态
     */
    func checkNetState() {
        let manger = AFNetworkReachabilityManager.sharedManager()
        manger.startMonitoring()
        manger.setReachabilityStatusChangeBlock { (state: AFNetworkReachabilityStatus) -> Void in
            if state == AFNetworkReachabilityStatus.NotReachable {
                let alertView = UIAlertView(title: "温馨提示", message: "网络异常", delegate: nil, cancelButtonTitle: "返回")
                alertView.show()
            }
        }
    }
    
    func processBackButton() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func processCloseButton() {
        navigationController?.popToRootViewControllerAnimated(true)
    }
}

extension String {
    
    var MD5: String {
        let cString = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let length = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cString!, length, result)
        return String(format: "%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15])
    }
    
    /**
     字符串补零操作
     */
    static func addZeroMethod(param: String) -> String {
        let number = Int(param)
        assert(number > 0, "参数不能小于零")
        if number < 10 {
            let strNumber = "0" + String(number!)
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
        let length = needSetString.characters.count
        attributeString.addAttributes([NSForegroundColorAttributeName : color], range: NSMakeRange(0, length))
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
        let size = stringName.boundingRectWithSize(maxSize, options:[NSStringDrawingOptions.UsesFontLeading, NSStringDrawingOptions.UsesLineFragmentOrigin] , attributes: [NSFontAttributeName: UIFont.systemFontOfSize(fontSize)], context: nil).size
        return size
    }
}


extension UIButton {
    static func initCustomButton(imagename: String, target: AnyObject?, action: Selector) -> UIButton {
        let button = UIButton()
        button.addTarget(target, action: action, forControlEvents: .TouchDown)
        button.setImage(UIImage(named: imagename), forState: .Normal)
        return button
    }
    
    /**
     设置button的backgroundImage图片
     */
    func setBackgroundImage(urlString: String, state: UIControlState, placeholderImageName: String) {
        let url = NSURL(string: urlString)
        let image = UIImage(named: placeholderImageName)
        self.sd_setBackgroundImageWithURL(url!, forState: state, placeholderImage: image)
    }
}

extension UIImageView {
    /**
     设置imageView的图片
     */
    func setImage(urlString: String, placeholderImageName: String) {
        let url = NSURL(string: urlString)
        let image = UIImage(named: placeholderImageName)
        self.sd_setImageWithURL(url!, placeholderImage: image)
    }
}