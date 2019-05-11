//
//  WJCommon.h
//
//  Created by ty on 15/12/25.
//  Copyright © 2015年 wangjie. All rights reserved.
//

#ifndef WJCommon_h
#define WJCommon_h



#ifdef DEBUG

// 自定义Log
#define WJLog(...) NSLog(__VA_ARGS__)
// 极光推送
#define JPUSHProductionState NO // 开发状态
// 网络请求域名
#define kServerDomain @"www.baidu.com/"

#else

#define WJLog(...)
#define JPUSHProductionState YES
#define kServerDomain @""

#endif


#pragma mark - 网络配置

// 接口版本管理
#define kVersion @"v-0.01/"
// 接口基本地址
#define kBaseUrl [NSString stringWithFormat:@"%@%@", kServerDomain, kVersion]

#pragma mark - Device
// 屏幕大小
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

// 是否是 isIphoneX
#define isIphoneX ((kScreenHeight >= 812.0) ? YES : NO)
#define KStatusHeight (isIphoneX ? 44 : 20)

// 底部导航高度
#define kBottomBarHeight (isIphoneX ? 83.0  : 49.0)  // 49 + 34
#define kNavgationbarHeight 44
#define kNavgationbarAndStatusHeight (KStatusHeight + kNavgationbarHeight)

#endif /* WJCommon_h */
