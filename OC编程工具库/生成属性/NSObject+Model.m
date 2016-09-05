//
//  NSObject+Model.m
//  iOS9新特性
//
//  Created by jhtwl on 16/5/25.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>

@implementation NSObject (Model)
+ (void)creatOurModelProperty:(NSDictionary *)dic
{
    NSMutableString * param = [NSMutableString string];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
        NSLog(@"%@ %@", [value class], value);
        
//        @property (nonatomic, strong, nonnull) NSString * smallName;
        
        if([NSStringFromClass([value class]) isEqualToString:@"__NSCFString"]) {
            [param appendFormat:@"\n%@\n",[NSString stringWithFormat:@"@property (nonatomic, %@) %@ * %@;", @"copy", @"NSString", key]];
        } else if ([NSStringFromClass([value class]) isEqualToString:@"__NSCFNumber"]) {
            [param appendFormat:@"\n%@\n",[NSString stringWithFormat:@"@property (nonatomic, %@) %@ * %@;", @"strong", @"NSNumber", key]];
        } else if ([NSStringFromClass([value class]) isEqualToString:@"__NSCFArray"]) {
            [param appendFormat:@"\n%@\n",[NSString stringWithFormat:@"@property (nonatomic, %@) %@ * %@;", @"strong", @"NSArray", key]];
        } else if ([NSStringFromClass([value class]) isEqualToString:@"__NSCFDictionary"]) {
            [param appendFormat:@"\n%@\n",[NSString stringWithFormat:@"@property (nonatomic, %@) %@ * %@;", @"strong", @"NSDictionary", key]];
        } else if ([NSStringFromClass([value class]) isEqualToString:@"__NSCFBoolean"]) {
            [param appendFormat:@"\n%@\n",[NSString stringWithFormat:@"@property (nonatomic, %@) %@ %@;", @"assign", @"BOOL", key]];
        }
    }];
    
    NSLog(@"param = %@", param);
}


+ (instancetype)modelWithDic:(NSDictionary *)dic
{
    id model = [[self alloc] init];
    
    NSLog(@"dic = %@", dic);
    unsigned int count = 0;
    objc_property_t * property = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        // 获取属性名
        const char * name = property_getName(property[i]);
        NSString * key = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSLog(@"key = %@，key.class = %@", key, [key class]);
        // 找值
        id value = dic[key];
        
        // 获取属性的类型
        const char * propertyType = property_getAttributes(property[i]);
        NSString * propertyTypeString = [NSString stringWithCString:propertyType encoding:NSUTF8StringEncoding];
        
        if ([value isKindOfClass:[NSDictionary class]] && ![propertyTypeString containsString:@"NSDictionary"]) {
            
            Class keyClass = NSClassFromString([self getCustomModelType:propertyTypeString]);
            NSLog(@"keyClass = %@",keyClass);
            id newValue = [keyClass modelWithDic:value];
            [model setValue:newValue forKey:key];
//        } else if ([value isKindOfClass:[NSArray class]] && ![propertyTypeString containsString:@"NSArray"]) {
//            NSLog(@"propertyTypeString = %@", propertyTypeString);
//            Class keyClass = NSClassFromString([self getCustomModelType:propertyTypeString]);
//            for (NSDictionary * obj in value) {
//                
//            }
        } else {
            [model setValue:value forKey:key];
        }
    }
    
    return model;
}


+ (NSString *)getCustomModelType:(NSString *)typeString
{
    return [typeString componentsSeparatedByString:@"\""][1];
}
@end
