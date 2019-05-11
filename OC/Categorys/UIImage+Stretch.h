//
//  UIImage+wjStretch.h
//  PinMa
//
//  Created by ty on 15/11/9.
//  Copyright © 2015年 ty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Stretch)

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/**
 *  @return 返回一张拉伸的图片
 */
+ (UIImage *)resizableImageName:(NSString *)imageName;

@end
