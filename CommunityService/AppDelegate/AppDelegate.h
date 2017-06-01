//
//  AppDelegate.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate,UIAlertViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)MBProgressHUD *mbprogressHUD;

// 高德地图
@property(nonatomic,strong)AMapLocationManager *locationManager;
@property(nonatomic,strong)AMapSearchAPI *amapSearchAPI;

@end

