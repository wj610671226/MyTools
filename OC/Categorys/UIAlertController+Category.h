//
//  UIAlertController+Category.h
//  EasyFuture
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 麦 芽糖. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CancelBlock)(void);
typedef void(^SureBlock)(void);

@interface UIAlertController (Category)

/**
 *  创建Alert样式的 UIAlertController
 */
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle cancelBlock:(CancelBlock)cancelBlock sureBlock:(SureBlock)sureBlock;
@end
