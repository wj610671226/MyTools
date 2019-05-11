//
//  NSString+dfdfd.h
//  PinMa
//
//  Created by ty on 15/11/9.
//  Copyright © 2015年 ty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Category)

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
+ (CGSize)stringSizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;


/**
 *  根据type获取对应字符串
 *  @param type 后缀类型
 *  return 20180428135414.jpg
 */
+ (NSString *)getCurrentTimestampsType:(NSString *)type;

// 获取当前时间戳 毫秒

+ (NSString *)getNowTimeTimestamp;
@end
