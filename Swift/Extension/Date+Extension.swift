//
//  Date.swift
//  ProjectExample
//
//  Created by J HD on 2016/11/28.
//  Copyright © 2016年 J HD. All rights reserved.
//

import Foundation

extension Date {
	
	/// 格式1 1992-06-09
	public var format1: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter.string(from: self)
	}
	
	/// 格式2 1992-06-09 24:11:11
	public var format2: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
		return formatter.string(from: self)
	}
	
	/// 格式3 1992年06月09日
	public var format3: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy年MM月dd日"
		return formatter.string(from: self)
	}
    
    /// 格式4 1992/06/09
    public var format4: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: self)
    }
	
	/// 格式5 06月09日 15:30
	public var format5: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM月dd日 HH:mm"
		return formatter.string(from: self)
	}
	
	/// 格式6 06月09日
	public var format6: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM月dd日"
		return formatter.string(from: self)
	}
	
	/// 格式7 1992/06/09 24:11:11
	public var format7: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
		return formatter.string(from: self)
	}
    
    /// 格式8 1992-06-09 24:11
    public var format8: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: self)
    }
}
