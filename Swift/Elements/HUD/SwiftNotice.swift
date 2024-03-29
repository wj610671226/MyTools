//
//  SwiftNotice.swift
//  SwiftNotice
//
//  Created by JohnLui on 15/4/15.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import Foundation
import UIKit

private let sntopBar: Int = 1001

extension UIResponder {

    @discardableResult
    func pleaseWaitWithImages(_ imageNames: [UIImage], timeInterval: Int) -> UIWindow {
        return SwiftNotice.wait(imageNames, timeInterval: timeInterval)
    }
    
    @discardableResult
    func noticeTop(_ text: String, autoClear: Bool = true, autoClearTime: Int = 1) -> UIWindow {
        return SwiftNotice.noticeOnStatusBar(text, autoClear: autoClear, autoClearTime: autoClearTime)
    }
    
    @discardableResult
    func noticeSuccess(_ text: String, autoClear: Bool = false, autoClearTime: Int = 3) -> UIWindow {
        return SwiftNotice.showNoticeWithText(NoticeType.success,
                                              text: text,
                                              autoClear: autoClear,
                                              autoClearTime: autoClearTime)
    }
    
    @discardableResult
    func noticeError(_ text: String, autoClear: Bool = false, autoClearTime: Int = 3) -> UIWindow {
        return SwiftNotice.showNoticeWithText(NoticeType.error,
                                              text: text,
                                              autoClear: autoClear,
                                              autoClearTime: autoClearTime)
    }
    
    @discardableResult
    func noticeInfo(_ text: String, autoClear: Bool = false, autoClearTime: Int = 3) -> UIWindow {
        return SwiftNotice.showNoticeWithText(NoticeType.info,
                                              text: text,
                                              autoClear: autoClear,
                                              autoClearTime: autoClearTime)
    }
    
    // old apis
    @discardableResult
    func successNotice(_ text: String, autoClear: Bool = true) -> UIWindow {
        return SwiftNotice.showNoticeWithText(NoticeType.success,
                                              text: text,
                                              autoClear: autoClear,
                                              autoClearTime: 3)
    }
    @discardableResult
    func errorNotice(_ text: String, autoClear: Bool = true) -> UIWindow {
        return SwiftNotice.showNoticeWithText(NoticeType.error,
                                              text: text,
                                              autoClear: autoClear,
                                              autoClearTime: 3)
    }
    @discardableResult
    func infoNotice(_ text: String, autoClear: Bool = true) -> UIWindow {
        return SwiftNotice.showNoticeWithText(NoticeType.info,
                                              text: text,
                                              autoClear: autoClear,
                                              autoClearTime: 3)
    }
    @discardableResult
    func notice(_ text: String, type: NoticeType, autoClear: Bool, autoClearTime: Int = 3) -> UIWindow {
        return SwiftNotice.showNoticeWithText(type,
                                              text: text,
                                              autoClear: autoClear,
                                              autoClearTime: autoClearTime)
    }
    @discardableResult
    func pleaseWait() -> UIWindow {
        return SwiftNotice.wait()
    }
    @discardableResult
    func noticeOnlyText(_ text: String) -> UIWindow {
        return SwiftNotice.showText(text)
    }
    func clearAllNotice() {
        SwiftNotice.clear()
    }
}

enum NoticeType {
    case success
    case error
    case info
}

class SwiftNotice: NSObject {
    static var windows: [UIWindow?] = Array()
    static let firstSubview = UIApplication.shared.keyWindow?.subviews.first as UIView?
    static var timer: DispatchSourceTimer!
    static var timerTimes = 0
    
    // fix https://github.com/johnlui/SwiftNotice/issues/2
    // thanks broccolii(https://github.com/broccolii) and his PR https://github.com/johnlui/SwiftNotice/pull/5
    static func clear() {
        self.cancelPreviousPerformRequests(withTarget: self)
        if timer != nil {
            timer.cancel()
            timer = nil
            timerTimes = 0
        }
        windows.removeAll(keepingCapacity: false)
    }
    
    @discardableResult
    static func noticeOnStatusBar(_ text: String, autoClear: Bool, autoClearTime: Int) -> UIWindow {
        let frame = UIApplication.shared.statusBarFrame
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        let view = UIView()
        view.backgroundColor = UIColor(red: 0x6a/0x100, green: 0xb4/0x100, blue: 0x9f/0x100, alpha: 1)
        
        let label = UILabel(frame: frame.height > 20 ?
                                CGRect(x: frame.origin.x,
                                       y: frame.origin.y + frame.height - 17,
                                       width: frame.width,
                                       height: 20) : frame)
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.text = text
        view.addSubview(label)
        
        window.frame = frame
        view.frame = frame
        
        window.windowLevel = UIWindow.Level.statusBar
        window.isHidden = false
        window.addSubview(view)
        windows.append(window)
        
        var origPoint = view.frame.origin
        origPoint.y = -(view.frame.size.height)
        let destPoint = view.frame.origin
        view.tag = sntopBar
        
        view.frame = CGRect(origin: origPoint, size: view.frame.size)
        UIView.animate(withDuration: 0.3, animations: {
            view.frame = CGRect(origin: destPoint, size: view.frame.size)
        }, completion: { _ in
            if autoClear {
                self.perform(.hideNotice, with: window, afterDelay: TimeInterval(autoClearTime))
            }
        })
        return window
    }
    
    @discardableResult
    static func wait(_ imageNames: [UIImage] = Array(), timeInterval: Int = 0) -> UIWindow {
        let frame = CGRect(x: 0, y: 0, width: 78, height: 78)
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        if imageNames.count > 0 {
            if imageNames.count > timerTimes {
                let imageView = UIImageView(frame: frame)
                imageView.image = imageNames.first!
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                mainView.addSubview(imageView)
                timer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)),
                                                       queue: DispatchQueue.main)
                timer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.milliseconds(timeInterval))
                timer.setEventHandler(handler: { () -> Void in
                    let name = imageNames[timerTimes % imageNames.count]
                    imageView.image = name
                    timerTimes += 1
                })
                timer.resume()
            }
        } else {
            let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
            indicatorView.frame = CGRect(x: 21, y: 21, width: 36, height: 36)
            indicatorView.startAnimating()
            mainView.addSubview(indicatorView)
        }
        
        window.frame = frame
        mainView.frame = frame
        window.center = firstSubview!.center
        window.windowLevel = UIWindow.Level.alert
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
        
        mainView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            mainView.alpha = 1
        })
        return window
    }
    
    @discardableResult
    static func showText(_ text: String, autoClear: Bool=true, autoClearTime: Int=2) -> UIWindow {
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        let mainView = UIView()
        mainView.layer.cornerRadius = 12
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        let size = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width-82,
                                             height: CGFloat.greatestFiniteMagnitude))
        label.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        mainView.addSubview(label)
        
        let superFrame = CGRect(x: 0, y: 0, width: label.frame.width + 50, height: label.frame.height + 30)
        window.frame = superFrame
        mainView.frame = superFrame
        
        label.center = mainView.center
        window.center = firstSubview!.center
  
        window.windowLevel = UIWindow.Level.alert
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
        
        if autoClear {
            self.perform(.hideNotice, with: window, afterDelay: TimeInterval(autoClearTime))
        }
        return window
    }
    
    @discardableResult
    static func showNoticeWithText(_ type: NoticeType, text: String, autoClear: Bool, autoClearTime: Int) -> UIWindow {
        //        let frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        let window = UIWindow()
        window.backgroundColor = UIColor.clear
        let mainView = UIView()
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        var image = UIImage()
        switch type {
        case .success:
            image = SwiftNoticeSDK.imageOfCheckmark
        case .error:
            image = SwiftNoticeSDK.imageOfCross
        case .info:
            image = SwiftNoticeSDK.imageOfInfo
        }
        let checkmarkView = UIImageView(image: image)
        checkmarkView.frame = CGRect(x: 27, y: 15, width: 36, height: 36)
        mainView.addSubview(checkmarkView)
        
        //        let label = UILabel(frame: CGRect(x: 0, y: 60, width: 90, height: 16))
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.text = text
        label.textAlignment = NSTextAlignment.center
        mainView.addSubview(label)
        
        let labelH: CGFloat = 16
        let padding: CGFloat = 5
        let maxSize = CGSize(width: 250, height: labelH)
        let labelWidth = getMessageWidth(message: text, maxSize: maxSize, fontSize: label.font) + padding * 2
        let labelX = padding
        label.frame = CGRect(x: labelX, y: 60, width: labelWidth, height: labelH)
        let totleW = labelWidth + padding * 2
        let frame = CGRect(x: 0, y: 0, width: totleW, height: 90)
        checkmarkView.center.x = totleW / 2
        
        window.frame = frame
        mainView.frame = frame
        window.center = firstSubview!.center
        
        window.windowLevel = UIWindow.Level.alert
        window.center = firstSubview!.center
        window.isHidden = false
        window.addSubview(mainView)
        windows.append(window)
        
        mainView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            mainView.alpha = 1
        })
        
        if autoClear {
            self.perform(.hideNotice, with: window, afterDelay: TimeInterval(autoClearTime))
        }
        return window
    }

    static func getMessageWidth(message: String, maxSize: CGSize, fontSize: UIFont) -> CGFloat {
        let string = message as NSString
        let size = string.boundingRect(with: maxSize,
                                       options: [NSStringDrawingOptions.usesFontLeading,
                                                 NSStringDrawingOptions.usesLineFragmentOrigin],
                                       attributes: [NSAttributedString.Key.font: fontSize],
                                       context: nil).size
        return size.width
    }
}

class SwiftNoticeSDK {
    
    struct Cache {
        static var imageOfCheckmark: UIImage?
        static var imageOfCross: UIImage?
        static var imageOfInfo: UIImage?
    }
    
    class func draw(_ type: NoticeType) {
        let checkmarkShapePath = UIBezierPath()
        // draw circle
        checkmarkShapePath.move(to: CGPoint(x: 36, y: 18))
        checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 18),
                                  radius: 17.5, startAngle: 0,
                                  endAngle: CGFloat(Double.pi*2), clockwise: true)
        checkmarkShapePath.close()
        switch type {
        case .success: // draw checkmark
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.addLine(to: CGPoint(x: 16, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 27, y: 13))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.close()
        case .error: // draw X
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 26))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 26))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 10))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.close()
        case .info:
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 22))
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.close()
            UIColor.white.setStroke()
            checkmarkShapePath.stroke()
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 27))
            checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 27),
                                      radius: 1,
                                      startAngle: 0,
                                      endAngle: CGFloat(Double.pi*2),
                                      clockwise: true)
            checkmarkShapePath.close()
            UIColor.white.setFill()
            checkmarkShapePath.fill()
        }
        UIColor.white.setStroke()
        checkmarkShapePath.stroke()
    }
    
    class var imageOfCheckmark: UIImage {
        if Cache.imageOfCheckmark != nil {
            return Cache.imageOfCheckmark!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        SwiftNoticeSDK.draw(NoticeType.success)
        Cache.imageOfCheckmark = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfCheckmark!
    }
    
    class var imageOfCross: UIImage {
        if Cache.imageOfCross != nil {
            return Cache.imageOfCross!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        SwiftNoticeSDK.draw(NoticeType.error)
        Cache.imageOfCross = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfCross!
    }
    
    class var imageOfInfo: UIImage {
        if Cache.imageOfInfo != nil {
            return Cache.imageOfInfo!
        }
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        SwiftNoticeSDK.draw(NoticeType.info)
        Cache.imageOfInfo = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return Cache.imageOfInfo!
    }
}

extension UIWindow {
    func hide() {
        SwiftNotice.hideNotice(self)
    }
}

fileprivate extension Selector {
    static let hideNotice = #selector(SwiftNotice.hideNotice(_:))
}

@objc extension SwiftNotice {
    static func hideNotice(_ sender: AnyObject) {
        if let window = sender as? UIWindow {
            if let subView = window.subviews.first {
                UIView.animate(withDuration: 0.2, animations: {
                    if subView.tag == sntopBar {
                        subView.frame = CGRect(x: 0,
                                               y: -subView.frame.height,
                                               width: subView.frame.width,
                                               height: subView.frame.height)
                    }
                    subView.alpha = 0
                }, completion: { _ in
                    if let index = windows.firstIndex(where: { (item) -> Bool in
                        return item == window
                    }) {
                        windows.remove(at: index)
                    }
                })
            }
        }
    }
}
