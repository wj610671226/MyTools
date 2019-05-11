//
//  UIImage+wjStretch.m
//  PinMa
//
//  Created by ty on 15/11/9.
//  Copyright © 2015年 ty. All rights reserved.
//  

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage * image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)resizableImageName:(NSString *)imageName
{
    UIImage * normal = [UIImage imageNamed:imageName];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    UIImage * newImage = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    return newImage;
}
@end
