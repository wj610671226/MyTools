//
//  EmptyDataSet.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/13.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

extension UIViewController: DZNEmptyDataSetSource {
    public func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "img_taskListEmpty")
    }
    
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let string = "暂无数据"
        let attr = [NSAttributedString.Key.foregroundColor : UIColor(hex: 0x8A9199), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        return NSAttributedString(string: string, attributes: attr)
    }
}

extension UIViewController: DZNEmptyDataSetDelegate {
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -100
    }
}
