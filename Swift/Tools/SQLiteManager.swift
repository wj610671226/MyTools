//
//  SQLiteManager.swift
//  CloudDisk
//
//  Created by 30san on 2019/6/21.
//  Copyright © 2019 Dawninest. All rights reserved.
//

import UIKit
import FMDB

class SQLiteManager: NSObject {

    public static let share = SQLiteManager()

    private let tableName = "category"
    private let sqliteName = "document"
    private static let key = "clouddisk"
    private let dbTool = SqliteTool(dbKey: SQLiteManager.key)

    override init() {
        let sql_stmt = "create table if not exists \(tableName) (id integer primary key not null,name text not null,pid integer not null default 0,type integer not null default 0,path text not null,level text,time text not null DEFAULT (datetime('now', 'localtime')))"
        _ = dbTool.openDatabase("\(sqliteName).sqlite", sql_stmt)
    }
    
    //增
    public func insert(data: SQLiteModel) {
        let dic = ["name": data.name, "pid": data.pid, "type": data.type, "path": data.path, "level": data.level] as [String : Any]
        dbTool.openDB()
        _  = dbTool.insertData(tableName, dic)
    }
    
    //删
    public func delete(data: SQLiteModel) -> Bool{
        dbTool.openDB()
        return dbTool.deleteData(tableName, condition: "id = \(data.Id)")
    }
    
    //删all
    public func deleteAll() {
        dbTool.openDB()
        _ = dbTool.deleteData(tableName, condition: nil)
    }
    
    //查
    //condition: "id = '2'"
    public func select(condition: String?) -> [SQLiteModel]?{
        dbTool.openDB()
        guard let result = dbTool.selectData(tableName, nil, condition: condition) else {
            DebugLog.info("查询数据失败")
            return nil
        }
        var array = [SQLiteModel]()
        while result.next() {
            array.append(SQLiteModel(result))
        }
        return array
    }
    
    //查
    //condition: "id = '2'"
    public func selectAll() -> [SQLiteModel]?{
        dbTool.openDB()
        guard let result = dbTool.selectData(tableName) else {
            DebugLog.info("查询数据失败")
            return nil
        }
        var array = [SQLiteModel]()
        while result.next() {
            array.append(SQLiteModel(result))
        }
        return array
    }
    
    //改
    public func update(data: SQLiteModel) {
        dbTool.openDB()
        let dic = ["name": data.name, "pid": data.pid, "type": data.type, "path": data.path, "level": data.level] as [String : Any]
        _ =  dbTool.updateData(tableName, dic, condition: "id = \(data.Id)")

    }
    
    //关闭
    public func close() {
        dbTool.closeDB()
    }
    
    public func description() {
        guard let result = dbTool.selectData(tableName) else {
            DebugLog.info("查询数据失败")
            return
        }
        
        while result.next() {
            let Id = result.int(forColumn: "id")
            let name = result.string(forColumn: "name") ?? ""
            let pid = result.int(forColumn: "pid")
            let type = result.int(forColumn: "type")
            let path = result.string(forColumn: "path") ?? ""
            let time = result.string(forColumn: "time") ?? ""
            
            print("id = \(Id) - name = \(name) - pid = \(pid) - type = \(type) - path = \(path) - time = \(time) - ")
        }
    }
}

struct SQLiteModel {
    
    var Id: Int32 = 0
    var name: String = "" //名称
    var pid: Int32 = 0 //唯一标识符
    var type: Int32 = 0 //0 下载 //1 上传
    var path: String = ""
    var time: String = ""
    var level: String = ""
    
    init(_ data: FMResultSet) {
        
        Id = data.int(forColumn: "pid")
        name = data.string(forColumn: "name") ?? ""
        pid = data.int(forColumn: "pid")
        type = data.int(forColumn: "type")
        path = data.string(forColumn: "path") ?? ""
        time = data.string(forColumn: "time") ?? ""
        level = data.string(forColumn: "level") ?? ""
    }
    
    init(name: String, pid: Int32, type: Int32, path: String, time: String, level: String) {
        self.name = name
        self.pid = pid
        self.type = type
        self.path = path
        self.time = time
        self.level = level
    }
}
