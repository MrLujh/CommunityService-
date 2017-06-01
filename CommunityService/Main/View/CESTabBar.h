//
//  CESTabBar.h
//  CommunityService
//
//  Created by lujh on 2017/4/26.
//  Copyright © 2017年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CESTabBar : UITabBar
@property(nonatomic,strong)UIButton *publishBtn;
@property (nonatomic,copy) void(^didClickPublishBtn)();
@end
