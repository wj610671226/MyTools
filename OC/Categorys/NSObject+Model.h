//
//  NSObject+Model.h
//  iOS9新特性
//
//  Created by jhtwl on 16/5/25.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+ (void)creatOurModelProperty:(NSDictionary *)dic;

+ (instancetype)modelWithDic:(NSDictionary *)dic;
@end
