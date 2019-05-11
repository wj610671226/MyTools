//
//  WJCustomButton.h
//  CustomButton
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WJCustomButtonTitlePositionEnum) {
    WJCustomButtonTitlePositionEnumLeft,
    WJCustomButtonTitlePositionEnumRight,
    WJCustomButtonTitlePositionEnumTop,
    WJCustomButtonTitlePositionEnumBottom
};

@interface WJCustomButton : UIButton

// 标题所占整个按钮比例
@property(nonatomic, assign)CGFloat titleScale;

// title在按钮中的位置   默认在左边
@property(nonatomic, assign)WJCustomButtonTitlePositionEnum titlePosition;
@end
