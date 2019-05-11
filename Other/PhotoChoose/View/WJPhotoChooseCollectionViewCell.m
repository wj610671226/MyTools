//
//  CollectionViewCell.m
//  BenNiaoSheQu
//
//  Created by ty on 16/1/7.
//  Copyright © 2016年 ty. All rights reserved.
//

#import "WJPhotoChooseCollectionViewCell.h"

@interface WJPhotoChooseCollectionViewCell ()

@property (nonatomic, weak) UIImageView * chooseImageView;
@end

@implementation WJPhotoChooseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 图片
        CGFloat itemW = self.frame.size.width;
        UIImageView * backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, itemW, itemW)];
        backImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:backImage];
        _backImage = backImage;
        
        // chooseImae
        CGFloat padding = 5;
        CGFloat chooseImageViewW = 25;
        CGFloat chooseImageViewH = chooseImageViewW;
        CGFloat chooseImageViewX = frame.size.width - chooseImageViewW - padding;
        CGFloat chooseImageViewY = padding;
        UIImageView * chooseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(chooseImageViewX, chooseImageViewY, chooseImageViewW, chooseImageViewH)];
        [backImage addSubview:chooseImageView];
        self.chooseImageView = chooseImageView;
        
        chooseImageView.image = [UIImage imageNamed:@"mc_forum_camera_checked"];
        chooseImageView.hidden = YES;
    }
    return self;
}

- (void)setIsCheck:(BOOL)isCheck
{
    _isCheck = isCheck;
    if (isCheck) {
        self.chooseImageView.hidden = NO;
    } else {
        self.chooseImageView.hidden = YES;
    }
}
@end
