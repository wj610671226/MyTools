//
//  NSString+dfdfd.m
//  PinMa
//
//  Created by ty on 15/11/9.
//  Copyright © 2015年 ty. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

+ (CGSize)stringSizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary * attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}


+ (NSString *)getCurrentTimestampsType:(NSString *)type {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString * str = [formatter stringFromDate:[NSDate date]];
    NSString * resylt = [NSString stringWithFormat:@"%@.%@", str, type];
    return resylt;
}

+ (NSString *)getNowTimeTimestamp {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"];
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate * datenow = [NSDate date];
    NSString * timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970] * 1000];
    return timeSp;
}

@end
