//
//  ShareAssetsLibrary.m
//  PrecisionPoverty
//
//  Created by jhtwl on 16/4/26.
//  Copyright © 2016年 jhtwl. All rights reserved.
//

#import "ShareAssetsLibrary.h"


@implementation ShareAssetsLibrary
static ALAssetsLibrary * library = nil;
+ (ALAssetsLibrary * )shareAssetsLibrary
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

@end
