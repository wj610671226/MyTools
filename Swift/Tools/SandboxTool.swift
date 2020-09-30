//
//  Sandbox.swift
//  CloudDisk
//
//  Created by 30san on 2019/5/20.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit

/*
 沙盒操作
 */
public class SandboxTool {
    
    // 程序目录，不能存任何东西
    public static func appPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.applicationDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }
    
    // 文档目录，需要ITUNES同步备份的数据存这里
    public static func docPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }
    
    // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
    public static func cachePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }
    
    // 临时目录，APP退出后，系统可能会删除这里的内容
    public static func tmpPath() -> String {
        let path = NSTemporaryDirectory()
        return path
    }
    
    public static func libPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }
    
}
