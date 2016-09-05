//
//  PickerImageTool.swift
//  PrecisionPoverty
//
//  Created by jhtwl on 16/5/11.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

import UIKit
import AVFoundation

enum pickType: String {
    case PhotoLibrary = "相册"
    case Camera = "相机"
}

// 选择图片或者相机
protocol PickerImageTool: UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate {
    // 选择图片
    func pickerImage()
}

extension PickerImageTool where Self: UIViewController {
    func pickerImage() {
        let actionSheet = UIActionSheet(title:"请选择", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: pickType.PhotoLibrary.rawValue, otherButtonTitles: pickType.Camera.rawValue)
        actionSheet.showInView(view)
    }
    
    // 打开相机
    func openCameraCompetence() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            if isOpenCamera() {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .Camera;
                // 设置前置摄像头
                imagePicker.cameraDevice = .Front
                presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    // 打开相册
    func openPhotoLibraryCompetence() {
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            if isOpenCamera() {
                // 系统相册
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .PhotoLibrary
//                imagePicker.mediaTypes = @[mediaType[0],mediaType[1]];
                presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }

    // 判断是否有访问相机的权限
    func isOpenCamera() -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        if authStatus == AVAuthorizationStatus.Denied || authStatus == AVAuthorizationStatus.Restricted {
            let message = "请在iPhone的“设置-隐私-相机”选项中，允许“\(NSBundle.mainBundle().infoDictionary!["CFBundleName"]!)”访问你的相机"
            let alertView = UIAlertView(title: "温馨提示", message: message, delegate: nil, cancelButtonTitle: "确定")
            alertView.show()
            return false
        }
        return true
    }
}