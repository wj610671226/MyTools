//
//  WJCustomButton.m
//  CustomButton
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WJCustomButton.h"

@implementation WJCustomButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleScale = self.titleScale == 0 ? 0.5 : self.titleScale;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect titleFrame = CGRectZero;
    if (self.titlePosition == WJCustomButtonTitlePositionEnumLeft) {
        titleFrame = CGRectMake(0, 0, contentRect.size.width * self.titleScale, contentRect.size.height);
    } else if (self.titlePosition == WJCustomButtonTitlePositionEnumRight) {
        titleFrame = CGRectMake(contentRect.size.width * (1 - self.titleScale), 0, contentRect.size.width * self.titleScale, contentRect.size.height);
    } else if (self.titlePosition == WJCustomButtonTitlePositionEnumTop) {
        titleFrame = CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * self.titleScale);
    } else {
        titleFrame = CGRectMake(0, contentRect.size.height * (1 - self.titleScale), contentRect.size.width, contentRect.size.height * self.titleScale);
    }
    return titleFrame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect imageFrame = CGRectZero;
    if (self.titlePosition == WJCustomButtonTitlePositionEnumLeft) {
        imageFrame = CGRectMake(contentRect.size.width * self.titleScale, 0, contentRect.size.width * (1 - self.titleScale), contentRect.size.height);
    } else if (self.titlePosition == WJCustomButtonTitlePositionEnumRight) {
        imageFrame = CGRectMake(0, 0, contentRect.size.width * (1 - self.titleScale), contentRect.size.height);
    } else if (self.titlePosition == WJCustomButtonTitlePositionEnumTop) {
        imageFrame = CGRectMake(0, contentRect.size.height * self.titleScale, contentRect.size.width, contentRect.size.height * (1 - self.titleScale));
    } else {
        imageFrame = CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1 - self.titleScale));
    }
    return imageFrame;
}

@end
