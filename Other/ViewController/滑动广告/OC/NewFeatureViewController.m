//
//  NewFeatureViewController.m
//  BenNiaoSheQu
//
//  Created by ty on 15/12/26.
//  Copyright © 2015年 ty. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "WJCommon.h"

@interface NewFeatureViewController ()<UIScrollViewDelegate>

/**
 *  存储图片名字
 */
@property (nonatomic, strong) NSArray * imageNames;

/**
 *  UIPageControl
 */
@property (nonatomic, weak) UIPageControl * pageControl;
@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加ScrollView
    [self addScrollView];
    
    // 添加UIPageControl
    [self addPageControl];
}

#pragma mark - 添加ScrollView
- (void)addScrollView
{
    NSInteger imageCount = self.imageNames.count;
    
    // 添加ScrollView
    UIScrollView * newFeatureScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:newFeatureScrollView];
    newFeatureScrollView.contentSize = CGSizeMake(ScreenW * imageCount, ScreenH);
    newFeatureScrollView.bounces = NO;
    newFeatureScrollView.pagingEnabled = YES;
    newFeatureScrollView.showsHorizontalScrollIndicator = NO;
    newFeatureScrollView.delegate = self;
    
    // 添加imageView
    for (int index = 0; index < self.imageNames.count; index ++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:self.imageNames[index]];
        imageView.frame = CGRectMake(ScreenW * index, 0, ScreenW, ScreenH);
        [newFeatureScrollView addSubview:imageView];
        
        
        // 最后一张图片上面添加进入应用按钮
        if (index == imageCount - 1) {
            UIButton * beginBtn = [[UIButton alloc] init];
            beginBtn.frame = CGRectMake(0, 0, 100, 30);
            [beginBtn addTarget:self action:@selector(processBeginBtn) forControlEvents:UIControlEventTouchDown];
            beginBtn.center = CGPointMake(ScreenW / 2, ScreenH / 5 * 4);
            [beginBtn setTitle:@"进入应用" forState:UIControlStateNormal];
            [beginBtn setBackgroundImage:[UIImage imageNamed:@"newFeature_back.png"] forState:UIControlStateNormal];
            [beginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            beginBtn.layer.cornerRadius = 15;
            beginBtn.clipsToBounds = YES;
            [imageView addSubview:beginBtn];
        }
    }
}

#pragma mark - 添加pageController
- (void)addPageControl
{
    // 添加
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, 0, 80, 20);
    pageControl.numberOfPages = self.imageNames.count;
    pageControl.center = CGPointMake(ScreenW / 2, ScreenH / 7 * 6);
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 设置颜色
    pageControl.currentPageIndicatorTintColor = RGBColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = RGBColor(189, 189, 189);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / ScreenW;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}

#pragma mark - processBeginBtn 进入应用
- (void)processBeginBtn
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"LoginViewController" bundle:nil];
    UIViewController * vc = [sb instantiateViewControllerWithIdentifier:@"navc"];
    self.view.window.rootViewController = vc;
}

- (NSArray *)imageNames
{
    if (_imageNames == nil) {
        _imageNames = [[NSArray alloc] initWithObjects:@"newFeature.png", @"newFeature1.png", @"newFeature2.png", @"newFeature3.png", nil];
    }
    return _imageNames;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
