//
//  SqliteTools.swift
//  SwiftDemo
//
//  Created by 30san on 2019/5/29.
//  Copyright © 2019 Dawninest. All rights reserved.
//
import FMDB

class SqliteTool {
    
    convenience init(dbKey: String?) {
        self.init()
        self.dbKey = dbKey
    }
    
    private let document = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    
    private var dataBase: FMDatabase!
    
    private var dbKey:String?
    
    func openDatabase(_ dbName: String,_ sql: String? = nil) -> Bool {
        if dbName.count <= 0 {
            fatalError("dbName not null")
        }
        
        let dbPath = String(format: "%@/%@", self.document, dbName)
        if !FileManager.default.fileExists(atPath: dbPath) {
            guard let sqlString = sql else {
                DebugLog.info("sql not nil")
                return false
            }
            let db = FMDatabase(path: dbPath)
            self.dataBase = db
            if !db.open() {
                DebugLog.info("数据库打开失败")

                return false
            }
            setDbKey()
            if !db.executeStatements(sqlString) {
                DebugLog.info(db.lastErrorMessage())

                return false
            }
//            db.close()
            return true
        }
        self.dataBase = FMDatabase(path: dbPath)
        
        return true
    }
    
    
    /*
     params 接收一个条件字典  select * from category where id = '2'
     condition 条件 select * from category where id > '2'
     */
    func selectData(_ tableName: String, _ params: [String: Any]? = nil, condition: String? = nil) -> FMResultSet? {
        if tableName.count <= 0 {
            fatalError("tableName not null")
        }
        
        var sql = "select * from \(tableName)"
        if let param = params {
            let key = param.keys.first! as String
            let value = param[key]!
            sql = sql + " where \(key) = '\(value)'"
        }
        
        if let conditionString = condition {
            sql = sql + " where " + conditionString
        }
        
        if self.dataBase != nil && self.dataBase.open() {
            setDbKey()
            let results = self.dataBase.executeQuery(sql, withParameterDictionary: nil)
            guard let result = results else {
                DebugLog.info("查询结果失败")

                self.dataBase.close()
                return nil
            }
            return result

        }
        return nil
    }
    
    func insertData(_ tableName: String, _ params: [String: Any]) -> Bool {
        if tableName.count <= 0 {
            fatalError("tableName not null")
        }
        let sql = contactSql(tableName, params)
        if self.dataBase != nil && self.dataBase.open() {
            setDbKey()
            let result = self.dataBase.executeUpdate(sql, withParameterDictionary: params)
            return result
        }
        return false
    }
    
    /// 批量插入数据
    func insertDatas(_ tableName: String, _ paramArray: [[String: Any]]) -> Bool {
        if tableName.count <= 0 {
            fatalError("tableName not null")
        }
        if self.dataBase != nil && self.dataBase.open() {
            setDbKey()
            self.dataBase.beginTransaction()
            for param in paramArray {
                let sql = contactSql(tableName, param)
                let result = self.dataBase.executeUpdate(sql, withParameterDictionary: param)
                if !result {
                    self.dataBase.rollback()
//                    self.dataBase.close()
                    DebugLog.info("批量插入数据失败")

                    return false
                }
            }
            self.dataBase.commit()
//            self.dataBase.close()
            return true
        }
        return false
    }
    
    /// 删除数据
    func deleteData(_ tableName: String, condition: String? = nil) -> Bool {
        if tableName.count <= 0 {
            fatalError("tableName not null")
        }
        var sql = "delete from \(tableName)"
        
        if let conditionString = condition {
            sql = sql + " where " + conditionString
        }
        
        if self.dataBase != nil && self.dataBase.open() {
            do {
                setDbKey()
                try self.dataBase.executeUpdate(sql, values: nil)
                return true
            } catch let error {
                DebugLog.info("删除数据错误 error = \(error)")
                return false
            }
        }
        return false
    }
    
    /// 更新数据
    func updateData(_ tableName: String, _ params: [String: Any], condition: String? = nil) -> Bool {
        if tableName.count <= 0 {
            fatalError("tableName not null")
        }
        // UPDATE t_student SET age = ?,title = ? WHERE name = ?
        var sql = "update \(tableName) set "
        let keys = params.keys
        var values = Array<Any>()
        for key in keys {
            sql = sql + "\(key)=?, "
            values.append(params[key]!)
        }
        sql = (sql as NSString).substring(to: sql.count - 2)
        if let conditionString = condition {
            sql = sql + " where " + conditionString
        }
        
        if self.dataBase != nil && self.dataBase.open() {
            do {
                setDbKey()
                try self.dataBase.executeUpdate(sql, values: values)
//                self.dataBase.close()
                return true
            } catch let error {
                DebugLog.info("更新数据错误 error = \(error)")
//                self.dataBase.close()
                return false
            }
        }
        return false
    }
    
    func closeDB() {
        if self.dataBase != nil && self.dataBase.isOpen {
            setDbKey()
            self.dataBase.close()
        }
    }
    
    func openDB() {
        if self.dataBase != nil && !self.dataBase.isOpen {
            setDbKey()
            self.dataBase.open()
        }
    }
    
    // MARK: - private
    private func dealParams(_ params: [String: Any]) -> (String, String) {
        let keys = params.keys
        let keyString = keys.joined(separator: ",")
        let valueString = keys.joined(separator: ",:")
        return (keyString, valueString)
    }
    
    /// 拼接插入sql语句
    private func contactSql(_ tableName: String, _ params: [String: Any]) -> String {
        let paramKeys = dealParams(params)
        return "insert into \(tableName)(\(paramKeys.0)) values(:\(paramKeys.1))"
    }
    
    
    private func setDbKey() {
        if let key = self.dbKey {
            self.dataBase.setKey(key)
        }
    }
    
    /*
     let sql_stmt = "create table if not exists localfiles(id integer primary key not null,name text not null,pid integer not null default 0,type integer not null default 0,path text not null,level text,time text not null DEFAULT (datetime('now', 'localtime')))"
     */
}
