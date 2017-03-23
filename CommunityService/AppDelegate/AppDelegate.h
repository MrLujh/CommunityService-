//
//  AppDelegate.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)MBProgressHUD *mbprogressHUD;

@end

