//
//  WJPickerView.h
//  EasyFuture
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 麦 芽糖. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^WJPickerViewCancleBlock)(void);
typedef void(^WJPickerViewSureBlock)(NSString * selectedData);

@interface WJPickerView : UIView

@property (nonatomic, strong) NSArray * pickDataSources;

@property (nonatomic, copy) WJPickerViewCancleBlock cancleBlcok;
@property (nonatomic, copy) WJPickerViewSureBlock sureBlcok;

+ (WJPickerView *)loadWJPickerViewWithXib;

@end
