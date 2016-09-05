//
//  WJPhotoChooseViewController.h
//  BenNiaoSheQu
//
//  Created by ty on 16/1/7.
//  Copyright © 2016年 ty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJPhotoChooseViewController.h"

@protocol WJPhotoChooseViewControllerDelegate <NSObject>

@optional
/**
 *  获取选择完成的照片
 */
- (void)photoChooseViewControllerDidFinishSelectedPhotos:(NSArray *)imageArray;

@end

@interface WJPhotoChooseViewController : UIViewController
/**
 *  设置最大的相片数量
 */
@property (nonatomic, assign) int maxPhotoNumber;

/**
 *  上次选择的照片
 */
@property (strong, nonatomic) NSArray * lastSelectedPhotosArray;

/**
 *  delegate
 */
@property (nonatomic, assign) id<WJPhotoChooseViewControllerDelegate> deleagte;
@end

