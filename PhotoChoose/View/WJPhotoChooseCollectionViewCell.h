//
//  CollectionViewCell.h
//  BenNiaoSheQu
//
//  Created by ty on 16/1/7.
//  Copyright © 2016年 ty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJPhotoChooseCollectionViewCell : UICollectionViewCell

/**
 *  照片
 */
@property (nonatomic, strong, readonly) UIImageView * backImage;

/**
 *  是否选中
 */
@property (nonatomic, assign) BOOL isCheck;
@end
