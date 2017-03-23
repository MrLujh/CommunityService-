//
//  AppDelegate.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "AppDelegate.h"
#import "CESTabBarController.h"
#import "CESNewFeatureController.h"
#import "CESNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AMapServices sharedServices].apiKey = @"289a6c9429edaa6b8e4659e6fabeaf11";
    
    [AMapServices sharedServices].enableHTTPS = YES;

    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    
    // v1.0
    // 判断当前是否有新的版本
    if ([currentVersion isEqualToString:lastVersion]) { // 没有最新的版本号
        
        // 创建tabBarVc
        CESTabBarController *tabBarVc = [[CESTabBarController alloc] init];
        
        // 设置窗口的根控制器
        self.window.rootViewController = tabBarVc;
        
        
    }else{ // 有最新的版本号
        
        // 进入新特性界面
        // 如果有新特性，进入新特性界面
        CESNewFeatureController *vc = [[CESNewFeatureController alloc] init];
        
        self.window.rootViewController = vc;
        
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kAppVersion];
    }
    
    
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    // makeKeyAndVisible底层实现
    // 1. application.keyWindow = self.window
    // 2. self.window.hidden = NO;
    
    
    //第一次获取一次
    if (([CESGetUserMessage getNoLoginUserId]== nil)) {
        
        [self getIdentifierWhenNoLogin];
        
    }

    return YES;

}

//获取无登陆标识

- (void)getIdentifierWhenNoLogin{
    
    self.mbprogressHUD = [[MBProgressHUD alloc] initWithView:self.window];
    
    [self.window addSubview:self.mbprogressHUD];
    
    self.mbprogressHUD.delegate = self;
    self.mbprogressHUD.label.text = @"Loading";
    
   // [self.mbprogressHUD showAnimated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[[UIDevice currentDevice].identifierForVendor UUIDString] forKey:@"imei"];
    
    NSString *lat = @"";
    NSString *lon = @"";
    
    NSString *locationFlag = [CESGetUserMessage getLocationFlag];
    if ([@"1" isEqualToString:locationFlag]) { //没有定位，渤海
        
        lat = [CESGetUserMessage getCurrentLatitude];
        lon = [CESGetUserMessage getCurrentLongitude];
        
    }else if([@"0" isEqualToString:locationFlag]){ //没有定位，渤海
        
        lat = @"38.52901";
        lon = @"119.82553";
    }
    [params setObject:lon forKey:@"longitude"];
    [params setObject:lat forKey:@"latitude"];
    [params setObject:kchannel_apk_name forKey:@"channel_apk_name"];
    
    if ([CESGetUserMessage getUserIdentifier]) {
        
        [params setObject:[CESGetUserMessage getUserIdentifier] forKey:@"imeiid"];
        
    }
    
    [CESHttpTool POST:kAPIGetNOLoginUserId parameters:params success:^(id responseObject) {
        NSLog(@"=====%@",responseObject);
        [self.mbprogressHUD hideAnimated:YES];
        
        int res = [[responseObject objectForKey:@"res"] intValue];
        
        if (res == 0) {
            
            NSNumber *u = [responseObject objectForKey:@"user_id"];
            NSString *uid = [NSString stringWithFormat:@"%@",u];
            
            [CESGetUserMessage saveNoLoginUserId:uid];
            
            NSLog(@"第一次无登陆id:%@",uid);
            
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            
            /***在这里来获取rongIM的一些信息**/
            NSDictionary *dicIM = [responseObject objectForKey:@"rongIM"];
            NSString *rongIMToken = [dicIM objectForKey:@"token"];
            NSString *rongUserid =  [dicIM objectForKey:@"userId"];
            
            if (rongIMToken) {
                
                [userDefault setObject:rongIMToken forKey:@"rongToken"];
                
            }
            if (rongUserid) {
                
                [userDefault setObject:rongUserid forKey:@"rongID"];
                
            }
            
            
            
            [userDefault setObject:[NSString stringWithFormat:@"%@",responseObject[@"token"]] forKey:@"noLoginToken"];
            
            [userDefault setObject:[NSString stringWithFormat:@"%@",responseObject[@"appkey"]] forKey:@"noLoginKey"];
            [userDefault synchronize];
            
            //更新clientId
            //            [[NSNotificationCenter defaultCenter]postNotificationName:kUpdateClientId object:nil];
            
            /*************添加上传设备信息请求*************/
            //          [EquipmentInformation uploadEquipmentInformation];//先不传，定位后补充上传
            
            
        }else{ //未获取到，继续重试
            
            NSString *msg = [responseObject objectForKey:@"msg"];
            
            NSLog(@"msg:%@",msg);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"获取数据异常,请检查后重试!" delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil,nil];
            alertView.tag = 101;
            [alertView show];
            
        }

        
    } failure:^(NSError *error) {
        
        [self.mbprogressHUD hideAnimated:YES];
        
        NSLog(@"result :%@",error);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"获取数据异常,请检查后重试!" delegate:self cancelButtonTitle:@"重试" otherButtonTitles:nil,nil];
        
        alertView.tag = 101;
        
        [alertView show];
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSInteger tag = alertView.tag;
    
    if (tag == 101) { //重新获取无登陆id
        
        if(buttonIndex == 0){ //重试
            
            if (([CESGetUserMessage getNoLoginUserId]== nil)) {
                
                [self getIdentifierWhenNoLogin];
                
            }
        }
    }
    
    if (tag == 102) { //退出
        exit(0);
        
        //        [self exitApplication];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
