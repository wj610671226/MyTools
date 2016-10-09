//
//  NetWorkingTool.swift
//  MyProtocal
//
//  Created by jhtwl on 16/8/15.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import AFNetworking

private let BASE_URL: String = ""

typealias CompleteHandler = (responseObject : AnyObject?, error: ErrorType?) -> Void

protocol NetWorkingTool {
    /**
     用于获取网络数据，POST
     
     - parameter urlString:    url地址
     - parameter param:        参数
     - parameter successBlock: 成功回调的闭包
     - parameter fileBlock:    失败回调的闭包
     */
    func baseNetWorking(urlString: String, param: NSDictionary, successBlock:(responseObject : AnyObject) -> Void,fileBlock:(error: NSError) -> Void)
    /**
     上传图片
     
     - parameter urlString:    url地址
     - parameter param:        参数
     - parameter imageNames:   图片名数组
     - parameter successBlock: 成功回调的闭包
     - parameter fileBlock:    失败回调的闭包
     */
    func upLoadFile(urlString: String, param: NSDictionary, imageArrays: NSArray, successBlock:(responseObject : AnyObject) -> Void,fileBlock:(error: NSError) -> Void)
    
    
    /**
     获取服务器数据，并转化为模型（对AlamofireObjectMapper进一步封装）
     
     - parameter url:          url地址
     - parameter params:       请求参数
     - parameter keyPath:      需要转模型的数据字段
     - parameter successBlock: 成功回调
     - parameter errorBlock:   失败回调
     */
    func requestGetDataFormServers<T: Mappable>(url: String, params:[String: String]?, keyPath: String?, successBlock: (result: T) -> Void, errorBlock: (error: NSError) -> Void)
}


extension NetWorkingTool {
    // MARK: 基于AFNetworking框架封装的网络请求
    func baseNetWorking(urlString: String, param: NSDictionary, successBlock:(responseObject : AnyObject) -> Void,fileBlock:(error: NSError) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json", "text/json", "text/javascript"]
        
        let url = BASE_URL + urlString
        
        manager.POST(url, parameters: param, progress: { (progress: NSProgress) -> Void in
            print("progress = \(progress)")
            }, success: { (task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                successBlock(responseObject: responseObject!)
        }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
            fileBlock(error: error)
        }
    }
    
    func upLoadFile(urlString: String, param: NSDictionary, imageArrays: NSArray, successBlock:(responseObject : AnyObject) -> Void,fileBlock:(error: NSError) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json", "text/json", "text/javascript"]
        
        let url = BASE_URL + urlString
        
        manager.POST(url, parameters: param, constructingBodyWithBlock: { (formData:AFMultipartFormData) -> Void in
            
            for image in imageArrays {
                let data = UIImageJPEGRepresentation(image as! UIImage, 0.5)
                let imageName = String(NSDate()) + ".png"
                formData.appendPartWithFileData(data!, name: "attachmentFiles", fileName: imageName, mimeType: "image/png")
            }
            
            }, progress: { (progress: NSProgress) -> Void in
                
            }, success: { (task: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                successBlock(responseObject: responseObject!)
        }) { (task: NSURLSessionDataTask?, error) -> Void in
            fileBlock(error: error)
        }
    }

    
    // MARK: 基于Alamofire框架封装的网络请求
    func alamofireNetWorking(urlString: String, param: [String: AnyObject]?, completeBlock:CompleteHandler) {
        
        let url: String = BASE_URL + urlString
        Alamofire.request(.POST, url, parameters: param).validate().responseJSON { (response) in
            switch response.result {
            case .Success:
                completeBlock(responseObject: response.result.value!, error: nil)
            case .Failure(let error):
                completeBlock(responseObject: nil, error: error)
            }
        }
    }
    
    func alamofireUpLoadFile(urlString: String, param: [String: AnyObject], imageArrays: NSArray, completeBlock:CompleteHandler) {
        let url = BASE_URL + urlString
        Alamofire.upload(.POST, url, multipartFormData: { (multipartFormData) in
            
            
            for image in imageArrays {
                let data = UIImageJPEGRepresentation(image as! UIImage, 0.5)
                let imageName = String(NSDate()) + ".png"
                multipartFormData.appendBodyPart(data: data!, name: "attachmentFiles", fileName: imageName, mimeType: "image/png")
            }
            
            // 这里就是绑定参数的地方
            for (key, value) in param {
                assert(value is String, "参数必须能够转换为NSData的类型，比如String")
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key )
            }
            
        }) { (encodingResult) in
            switch encodingResult {
            case .Success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    completeBlock(responseObject: response.result.value!, error: nil)
                })
            case .Failure(let error):
                completeBlock(responseObject: nil, error: error)
            }
        }
    }
    
    
    /**
     获取服务器数据，并转化为模型（对AlamofireObjectMapper进一步封装）
     
     - parameter url:          url地址
     - parameter params:       请求参数
     - parameter keyPath:      需要转模型的数据字段
     - parameter successBlock: 成功回调
     - parameter errorBlock:   失败回调
     */
    func requestGetDataFormServers<T: Mappable>(url: String, params:[String: String]? = nil, keyPath: String? = nil, successBlock: (result: T) -> Void, errorBlock: (error: NSError) -> Void) {
        Alamofire.request(.POST, url, parameters: params).responseObject(keyPath: keyPath) { (response: Response<T, NSError>) in
            if let err = response.result.error {
                errorBlock(error:err)
            } else {
                successBlock(result: response.result.value!)
            }
        }
    }
}