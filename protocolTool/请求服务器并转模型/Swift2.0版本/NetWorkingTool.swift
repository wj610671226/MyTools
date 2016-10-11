//
//  NetWorkingTool.swift
//  NewStudy
//
//  Created by jhtwl on 16/10/8.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import AFNetworking
import MJExtension

protocol NetWorkingTool {
    
}

extension NetWorkingTool {
    
    /**
     获取服务器数据，并转化为模型（对AlamofireObjectMapper进一步封装）
     
     - parameter url:          url地址
     - parameter params:       请求参数
     - parameter keyPath:      需要转模型的数据字段
     - parameter successBlock: 成功回调
     - parameter errorBlock:   失败回调
     */
    func alRequestGetDataFormServers<T: Mappable>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: (result: T) -> Void, errorBlock: (error: NSError) -> Void) {
        Alamofire.request(.POST, url, parameters: params).responseObject(keyPath: keyPath) { (response: Response<T, NSError>) in
            if let err = response.result.error {
                errorBlock(error:err)
            } else {
                successBlock(result: response.result.value!)
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
    func alRequestGetDataFormServersCallbackArray<T: Mappable>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: (result: [T]) -> Void, errorBlock: (error: NSError) -> Void) {
        Alamofire.request(.POST, url, parameters: params).responseArray(keyPath: keyPath) { (response:Response<[T], NSError>) in
            if let err = response.result.error {
                errorBlock(error:err)
            } else {
                successBlock(result: response.result.value!)
            }
        }
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
    func afRequestGetDataFormServers<T: NSObject>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: (result: T) -> Void, errorBlock: (error: NSError) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json", "text/json", "text/javascript"]
        
        manager.POST(url, parameters: params, progress: { (progress: NSProgress) -> Void in
            print("progress = \(progress)")
            }, success: { (task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                print("responseObject = \(responseObject)")
                
                let value = self.checkKeyPathEffective(keyPath, responseObject: responseObject)
                if value != nil {
                    let model = T.mj_objectWithKeyValues(value)
                    successBlock(result: model)
                } else {
                    print("---获取的数据为空---")
                }
                
        }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            errorBlock(error:error)
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
    func afRequestGetDataFormServersCallbackArray<T: NSObject>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: (result: [T]) -> Void, errorBlock: (error: NSError) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json", "text/json", "text/javascript"]
        
        manager.POST(url, parameters: params, progress: { (progress: NSProgress) -> Void in
            print("progress = \(progress)")
            }, success: { (task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                
                let value = self.checkKeyPathEffective(keyPath, responseObject: responseObject)
                if value != nil {
                    let data = T.mj_objectArrayWithKeyValuesArray(value)
                    var model: [T] = Array()
                    for obj in data {
                        let m = obj as! T
                        model.append(m)
                    }
                    successBlock(result: model)
                } else {
                    print("---获取的数据为空---")
                }
                
        }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            errorBlock(error:error)
        }
    }
    
    // 根据keypath返回需要转化模型的json字符串
    private func checkKeyPathEffective(keyPath: String?, responseObject: AnyObject?) -> AnyObject? {
        var value: AnyObject?
        if keyPath != "" && keyPath != nil {
            value = responseObject!.valueForKeyPath(keyPath!)
        } else {
            value = responseObject
        }
        return value
    }
}

