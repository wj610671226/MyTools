//
//  UIColor+Category.h
//  EasyFuture
//
//  Created by wangjie on 2018/4/25.
//  Copyright © 2018年 麦 芽糖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/**
 *  RGB色
 */
+ (UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

/**
 *  16 进制RGB色
 *
 *  @param hex    16进制颜色值
 *  @param alpha  alpha
 */
+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha;

/**
 *  随机颜色
 */
+ (UIColor *)randomColor;
@end
