//
//  AppMacro.h
//  CommunityService
//
//  Created by lujh on 2016/12/13.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#define KUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define KUIScreenHeight [UIScreen mainScreen].bounds.size.height
//一些缩写
#define kApplication  [UIApplication sharedApplication]
#define kKeyWindow [UIApplication sharedApplication].keyWindow
#define kAppDelegate [UIApplication sharedApplication].delegate
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
/*
 *  数据库文件
 */
#define POSITIONSQLITE @"modals.sqlite"
//APP版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本号
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//判断是否为iPhone
#define kISiPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define kISiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define LoadImage(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define LoadDefaultImage_S LoadImage(@"image_default_s",@"png")
#define LoadDefaultImage_L LoadImage(@"image_default_l",@"jpg")


#define kHomeViewController                      @"kHomeViewController" //首页
#define kCardShopListViewController              @"kCardShopListViewController" //卡包商铺列表

#define KNotificationMyViewCtrlHasNotReadMsg              @"KNotificationMyViewCtrlHasNotReadMsg" //

#define khasRemoteNotification              @"khasRemoteNotification" // 有远程通知


#define kRefreshShopCartNotification     @"kRefreshShopCartNotification"                       //刷新购物车通知

#define kUpdateClientId    @"kUpdateClientId"


//渠道
#define kchannel_apk_name  @"esever"
//#define kchannel_apk_name  @"efwsdxeqmkt"


//提示语
#define kNetWorkError @"网络不给力,请检查网络!"
#define kErrorOrNoNetWork @"网络无法连接，请联网后重试"
//app 配置

#define PageSize 10

#define HotPhone @"4000-789-000"

//本地数据库表名
#define KabaoKeyWordTable     @"KABAOKEYWORDTABLE"

#define LocationWordTable     @"LOCATIONKEYWORDTABLE"

/*
 * token appkey
 */
#define KToken                @"suToken"
#define KAppkey               @"suAppkey"
#define kTokenAndAppkey       @"tokenAndAppkey"


//保存本地登录信息
#define kLocalUserID @"userid"  //
#define kLocalUserName @"username"  //nickname
#define kLoginPhone @"phone"

//保存本地无登录信息
#define kNoLoginUserID @"nologinUserId"  //

#define kLocationAddress @"LocationAddress"  //

#define kHasSelectLocationAddress @"HasSelectLocationAddress"  //


//保存是否定位标示
#define kLocationFlag @"kLocationFlag"  //

#define kGPSCID  @"gps_cid"
#define kGPSCName  @"gps_cname"

#define kLocalCommID @"commid"
#define kLocalCommName @"commlocalname"
#define kLocalCommLevel @"kLocalCommLevel"

#define kSelectCommID    @"kSelectCommID"
#define kSelectCommName  @"kSelectCommName"
#define kSelectCommLevel @"kSelectCommLevel"
#define kSelectFlag @"kSelectFlag"


#define kLocalFinalPID @"final_pid"
#define kLocalFinalPName @"final_pname"

//当前经纬度
#define kCurrentLongitude @"current_longitude"
#define kCurrentLatitude  @"current_latitude"

//持续定位的经纬度
#define kConntinuousLocation  @"conntinuous_location"

#define kCurrentShopID @"currentshopid"

#define kBannerImageKey @"picname"

/**
 *  购物车
 */

#define kShopcartShopId  @"shopcart_shopid_select"



// 购物车 plist 文件
//
//#define kShopcartFile  @"shop_cart.plist"

//自提点信息
#define kBreakFastZTId  @"kBreakFastZTId"
#define kBreakFastZTAddress  @"kBreakFastZTAddress"
//版本判读
#define CESVersionKey @"version"

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define CESColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define CESTabBarButtonImageRatio 0.6
#define CESTabBarButtonTitleColor (iOS7 ? [UIColor blackColor]:[UIColor whiteColor])
#define CESTabBarButtonTitleSelectedColor (iOS7 ? CESColor(206, 8, 2):CESColor(206, 8, 2))

#endif /* AppMacro_h */
