//
//  NetWorkingTool.swift
//  MyProtocal
//
//  Created by jhtwl on 16/8/15.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

//import ObjectMapper
//import AlamofireObjectMapper
import AFNetworking
import Alamofire

private let BASE_URL: String = ""

typealias CompleteHandler = (_ responseObject : Any?, _ error: Error?) -> Void

protocol NetWorkingTool {
    /**
     用于获取网络数据，POST
     
     - parameter urlString:    url地址
     - parameter param:        参数
     - parameter successBlock: 成功回调的闭包
     - parameter fileBlock:    失败回调的闭包
     */
    func baseNetWorking(urlString: String, param: NSDictionary, successBlock: @escaping (_ responseObject : Any) -> Void, failBlock: @escaping (_ error: Error) -> Void)
    /**
     上传图片
     
     - parameter urlString:    url地址
     - parameter param:        参数
     - parameter imageNames:   图片名数组
     - parameter successBlock: 成功回调的闭包
     - parameter fileBlock:    失败回调的闭包
     */
    func upLoadFile(urlString: String, param: NSDictionary, imageArrays: NSArray, successBlock: @escaping (_ responseObject : Any) -> Void, failBlock: @escaping (_ error: Error) -> Void)
}


extension NetWorkingTool {
    // MARK: 基于AFNetworking框架封装的网络请求
    func baseNetWorking(urlString: String, param: NSDictionary, successBlock: @escaping (_ responseObject : Any) -> Void, failBlock: @escaping (_ error: Error) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json", "text/json", "text/javascript"]
        
        let url = BASE_URL + urlString
        manager.post(url, parameters: param, headers: nil, progress: { (progress: Progress) -> Void in
            print("progress = \(progress)")
        }, success: { (task: URLSessionDataTask, responseObject: Any?) -> Void in
            successBlock(responseObject!)
        }) { (task: URLSessionDataTask?, error: Error) -> Void in
            failBlock(error)
        }
    }
    
    func upLoadFile(urlString: String, param: NSDictionary, imageArrays: NSArray, successBlock: @escaping (_ responseObject : Any) -> Void, failBlock: @escaping (_ error: Error) -> Void) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = ["text/html", "application/json", "text/json", "text/javascript"]
        
        let url = BASE_URL + urlString
        
        manager.post(url, parameters: param, headers: nil, constructingBodyWith: { (formData:AFMultipartFormData) -> Void in
            
            for image in imageArrays {
                let data = (image as! UIImage).jpegData(compressionQuality: 0.5)
                let imageName = "\(NSDate())" + ".png"
                formData.appendPart(withFileData: data!, name: "attachmentFiles", fileName: imageName, mimeType: "image/png")
            }
            
            }, progress: { (progress: Progress) -> Void in
                
        }, success: { (task: URLSessionDataTask, responseObject: Any?) -> Void in
            successBlock(responseObject!)
        }) { (task: URLSessionDataTask?, error) -> Void in
            failBlock(error)
        }
    }

    
    // MARK: 基于Alamofire框架封装的网络请求
    func alamofireNetWorking(urlString: String, param: [String: Any]?, completeBlock: @escaping CompleteHandler) {
        let url: String = BASE_URL + urlString
        Alamofire.request(url, method: .post, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                completeBlock(value, nil)
            case .failure(let error):
                completeBlock(nil, error)
            }
        }
    }
    
    func alamofireUpLoadFile(urlString: String, param: [String: Any], imageArrays: NSArray, completeBlock: @escaping CompleteHandler) {
        let url = BASE_URL + urlString
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for image in imageArrays {
                let data = (image as! UIImage).jpegData(compressionQuality: 0.5)
                let imageName = "\(NSDate())" + ".png"
                multipartFormData.append(data!, withName: "attachmentFiles", fileName: imageName, mimeType: "image/png")
            }
        }, to: url) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    print("response = \(response)")
                    completeBlock(response.result.value!, nil)
                })
            case .failure(let error):
                completeBlock(nil, error)
            }
        }
    }
}
