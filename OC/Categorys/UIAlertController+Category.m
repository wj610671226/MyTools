//
//  UIAlertController+Category.m
//  EasyFuture
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 麦 芽糖. All rights reserved.
//

#import "UIAlertController+Category.h"

@implementation UIAlertController (Category)

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle cancelBlock:(CancelBlock)cancelBlock sureBlock:(SureBlock)sureBlock {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle.length != 0) {
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alert addAction:cancel];
    }
    
    if (sureTitle.length != 0) {
        UIAlertAction * sure = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock();
            }
        }];
        [alert addAction:sure];
    }
    
    return alert;
}
@end
