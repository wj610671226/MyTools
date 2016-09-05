//
//  NetWorkingTool.swift
//  MyProtocal
//
//  Created by jhtwl on 16/8/15.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit

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
}