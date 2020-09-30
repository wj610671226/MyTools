//
//  NetWorkingTool.swift
//  NewStudy
//
//  Created by jhtwl on 16/10/8.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import AFNetworking
import MJExtension
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

protocol NetWorkingToolToModel {
    
}

extension NetWorkingToolToModel {
    
    /**
     获取服务器数据，并转化为模型（对AlamofireObjectMapper进一步封装）
     
     - parameter url:          url地址
     - parameter params:       请求参数
     - parameter keyPath:      需要转模型的数据字段
     - parameter successBlock: 成功回调
     - parameter errorBlock:   失败回调
     */
    func alRequestGetDataFormServers<T: Mappable>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: @escaping (_ result: T) -> Void, errorBlock: @escaping (_ error: Error) -> Void) {
        
        Alamofire.request(url, method: .post, parameters: params).responseObject(keyPath: keyPath) { (response:DataResponse<T>) in
            if let err = response.result.error {
                errorBlock(err)
            } else {
                successBlock(response.result.value!)
            }
        }
    }
    
    /**
     获取服务器数据，并转化为模型，适用于一个字典数组（对AlamofireObjectMapper进一步封装）
     
     - parameter url:          url地址
     - parameter params:       请求参数
     - parameter keyPath:      需要转模型的数据字段
     - parameter successBlock: 成功回调
     - parameter errorBlock:   失败回调
     */
    func alRequestGetDataFormServersCallbackArray<T: Mappable>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: @escaping (_ result: [T]) -> Void, errorBlock: @escaping (_ error: Error) -> Void) {
//        Alamofire.request(url, method: .post, parameters: params).responseArray(keyPath: keyPath) { (response: DataResponse<[T]>) in
//            if let err = response.result.error {
//                errorBlock(err)
//            } else {
//                successBlock(response.result.value!)
//            }
//        }
    }
    
    
    /**
     获取服务器数据，并转化为模型，适用于字典转模型（对AFNetworking、MJExtension进一步封装）
     result：一定要指定model类型
     - parameter url:          url地址
     - parameter params:       请求参数
     - parameter keyPath:      需要转模型的数据字段
     - parameter successBlock: 成功回调
     - parameter errorBlock:   失败回调
     */
    func afRequestGetDataFormServers<T: NSObject>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: @escaping (_ result: T) -> Void, errorBlock: @escaping (_ error: Error) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json", "text/json", "text/javascript"]
        
        manager.post(url, parameters: params, headers: nil, progress: { (progress: Progress) -> Void in
            print("progress = \(progress)")
            }, success: { (task: URLSessionDataTask, responseObject: Any?) -> Void in
                print("responseObject = \(responseObject)")
                
                let value = self.checkKeyPathEffective(keyPath: keyPath, responseObject: responseObject as AnyObject?)
                
                if value != nil {
                    let model = T.mj_object(withKeyValues: value)
                    successBlock(model!)
                } else {
                    print("---获取的数据为空---")
                }
                
        }) { (task: URLSessionDataTask?, error: Error) -> Void in
            errorBlock(error)
        }
    }
    
    
    /**
     获取服务器数据，并转化为模型，适用于字典数组转模型数组（对AFNetworking、MJExtension进一步封装）
     result：一定要指定model类型
     - parameter url:          url地址
     - parameter params:       请求参数
     - parameter keyPath:      需要转模型的数据字段
     - parameter successBlock: 成功回调
     - parameter errorBlock:   失败回调
     */
    func afRequestGetDataFormServersCallbackArray<T: NSObject>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: @escaping (_ result: [T]) -> Void, errorBlock: @escaping (_ error: Error) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json", "text/json", "text/javascript"]
        
        manager.post(url, parameters: params, headers: nil, progress: { (progress: Progress) -> Void in
            print("progress = \(progress)")
            }, success: { (task: URLSessionDataTask, responseObject: Any?) -> Void in
                
                let value = self.checkKeyPathEffective(keyPath: keyPath, responseObject: responseObject as AnyObject?)
                if value != nil {
                    let data = T.mj_objectArray(withKeyValuesArray: value)
                    var model: [T] = Array()
                    for obj in data! {
                        let m = obj as! T
                        model.append(m)
                    }
                    successBlock(model)
                } else {
                    print("---获取的数据为空---")
                }
        }) { (task: URLSessionDataTask?, error: Error) -> Void in
            errorBlock(error)
        }
    }
    
    // 根据keypath返回需要转化模型的json字符串
    private func checkKeyPathEffective(keyPath: String?, responseObject: AnyObject?) -> Any? {
        var value: Any?
        if keyPath != "" && keyPath != nil {
            value = responseObject?.value(forKeyPath: keyPath!)
        } else {
            value = responseObject
        }
        return value
    }
}

