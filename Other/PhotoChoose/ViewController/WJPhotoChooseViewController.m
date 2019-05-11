//
//  WJPhotoChooseViewController.m
//  BenNiaoSheQu
//
//  Created by ty on 16/1/7.
//  Copyright © 2016年 ty. All rights reserved.
//

#import "WJPhotoChooseViewController.h"
#import "WJPhotoChooseCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ShareAssetsLibrary.h"

#define CollectionItemSize(a) CGSizeMake(a, a)
#define WJPhotoChooseCollectionViewCellID @"WJPhotoChooseCollectionViewCellID"
#define cellpadding 4
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface WJPhotoChooseViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

/**
 *  数据源
 */
@property (nonatomic, strong) NSMutableArray * photoChooseDataSources;

/**
 *  tabeleView
 */
@property (nonatomic, weak) UICollectionView * photoChooseCollectionView;

/**
 *  存储选中的图片
 */
@property (nonatomic, strong) NSMutableArray * selectImagesArray;

@property (nonatomic, strong) ALAssetsLibrary * alAssetsLibrary;

@property (nonatomic, assign) BOOL sign;
@end

@implementation WJPhotoChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化photoChooseCollectionView
    [self initPhotoChooseCollectionView];
    
    // 获取照片
    [self getCurrentPhoto];
    
    self.sign = NO;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(processRightItem)];
}

#pragma mark - 完成选择
- (void)processRightItem
{
    // 通知代理
    if (self.deleagte && [self.deleagte respondsToSelector:@selector(photoChooseViewControllerDidFinishSelectedPhotos: )]) {
        [self.deleagte photoChooseViewControllerDidFinishSelectedPhotos:self.selectImagesArray];
    }
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - 初始化photoChooseCollectionView
- (void)initPhotoChooseCollectionView
{
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    backgroundView.backgroundColor = [UIColor colorWithRed:229 / 255.0 green:57 / 255.0 blue:57 / 255.0 alpha:1];
    [self.view addSubview:backgroundView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 42);
    titleLabel.text = @"请选择图片";
    [backgroundView addSubview:titleLabel];
    
    CGFloat rightW = 50;
    UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - rightW, 20, rightW, 44)];
    [rightButton addTarget:self action:@selector(processRightItem) forControlEvents:UIControlEventTouchDown];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backgroundView addSubview:rightButton];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 每一行之间的距离
    flowLayout.minimumLineSpacing = cellpadding;
    // 每个cell左右之间的距离
    flowLayout.minimumInteritemSpacing = cellpadding;
    // 滚动方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    UICollectionView * photoChooseCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64) collectionViewLayout:flowLayout];
    [photoChooseCollectionView registerClass:[WJPhotoChooseCollectionViewCell class] forCellWithReuseIdentifier:WJPhotoChooseCollectionViewCellID];
    photoChooseCollectionView.delegate = self;
    photoChooseCollectionView.dataSource = self;
    photoChooseCollectionView.showsVerticalScrollIndicator = NO;
    self.photoChooseCollectionView = photoChooseCollectionView;
    photoChooseCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:photoChooseCollectionView];
}

#pragma mark - 获取照片
- (void)getCurrentPhoto
{
    self.alAssetsLibrary = [ShareAssetsLibrary shareAssetsLibrary];
    [self.alAssetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [self.photoChooseDataSources addObject:result];
                    [self.photoChooseCollectionView reloadData];
                }
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"加载照片失败");
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoChooseDataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJPhotoChooseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:WJPhotoChooseCollectionViewCellID forIndexPath:indexPath];

    ALAsset * asset = self.photoChooseDataSources[indexPath.row];
    
    UIImage * image  = [UIImage imageWithCGImage:[asset thumbnail]];
    
    // 设置图片
    cell.backImage.image = image;
    
    for (int i = 0; i < self.selectImagesArray.count; i ++) {
        if ([[[[self.photoChooseDataSources[indexPath.row] defaultRepresentation] url] absoluteString] isEqualToString:[[[self.selectImagesArray[i] defaultRepresentation] url] absoluteString]]) {
//            cell.isCheck = YES;
            self.sign = YES;
        }
    }
    
    if (self.sign) {
        cell.isCheck = YES;
        self.sign = NO;
    } else {
        cell.isCheck = NO;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CollectionItemSize((ScreenW - 4 * cellpadding) / 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(cellpadding, cellpadding, cellpadding, cellpadding);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WJPhotoChooseCollectionViewCell * cell = (WJPhotoChooseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    // 判断是否超过照片的最大设置数目
    if (!cell.isCheck) {
        if (self.selectImagesArray.count >= self.maxPhotoNumber) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"最多选择%d张", self.maxPhotoNumber] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }
    
    cell.isCheck = !cell.isCheck;
    // 选中的图片加入字典
    if (cell.isCheck) {
        [self.selectImagesArray addObject:self.photoChooseDataSources[indexPath.row]];
    } else {
        for (int i = 0; i < self.selectImagesArray.count; i ++) {
            if ([[[[self.photoChooseDataSources[indexPath.row] defaultRepresentation] url] absoluteString] isEqualToString:[[[self.selectImagesArray[i] defaultRepresentation] url] absoluteString]]) {
                [self.selectImagesArray removeObject:self.selectImagesArray[i]];
            }
        }
        
    }
}

#pragma mark - 数据源懒加载
- (NSMutableArray *)photoChooseDataSources
{
    if (_photoChooseDataSources == nil) {
        _photoChooseDataSources = [[NSMutableArray alloc] init];
    }
    return _photoChooseDataSources;
}

- (NSMutableArray *)selectImagesArray
{
    if (_selectImagesArray == nil) {
        _selectImagesArray = [[NSMutableArray alloc] initWithArray:self.lastSelectedPhotosArray];
    }
    return _selectImagesArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
