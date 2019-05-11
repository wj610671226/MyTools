//
//  UIColor+Category.m
//  EasyFuture
//
//  Created by wangjie on 2018/4/25.
//  Copyright © 2018年 麦 芽糖. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
    return [UIColor colorWithRed: r / 255.0 green: g / 255.0 blue: b / 255.0 alpha:1];
}

+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha
{
//    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
//                           green:((float)((hex & 0xFF00) >> 8)) / 255.0
//                            blue:((float)(hex & 0xFF)) / 255.0
//                           alpha:(alpha)];
    
    return [self colorWithR:(hex & 0xFF0000) >> 16 g:(hex & 0xFF00) >> 8 b:hex & 0xFF];
}

+ (UIColor *)randomColor {
    return [self colorWithR:arc4random_uniform(256) g:arc4random_uniform(256) b:arc4random_uniform(256)];
}
@end
