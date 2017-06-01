//
//  CESTabBarController.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "CESTabBarController.h"
#import "HomeViewController.h"
#import "FindViewController.h"
#import "VoucherViewController.h"
#import "CESPlusViewController.h"
#import "CESNavigationController.h"
#import "MyViewController.h"
#import "CESTabBar.h"
@interface CESTabBarController ()

@end

@implementation CESTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有控制器
    [self setUpChildVC];
    
    // 创建tabbar中间的tabbarItem
    [self setUpMidelTabbarItem];
    
}

#pragma mark -创建tabbar中间的tabbarItem

- (void)setUpMidelTabbarItem {
    
    CESTabBar *tabBar = [[CESTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    __weak typeof(self) weakSelf = self;
    [tabBar setDidClickPublishBtn:^{
        
        CESPlusViewController *plusVC = [[CESPlusViewController alloc] init];
        CESNavigationController *nav = [[CESNavigationController alloc] initWithRootViewController:plusVC];
        [weakSelf presentViewController:nav animated:YES completion:nil];
        
    }];
    
}

#pragma mark -初始化所有控制器

- (void)setUpChildVC {
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.tabBarItem.badgeValue = @"1111";
    [self setChildVC:homeVC title:@"首页" image:@"tabbar_home_normal" selectedImage:@"tabbar_home_select"];
    
    FindViewController *fishpidVC = [[FindViewController alloc] init];
    [self setChildVC:fishpidVC title:@"发现" image:@"tabbar_find_normal" selectedImage:@"tabbar_find_select"];
    
    VoucherViewController *messageVC = [[VoucherViewController alloc] init];
    [self setChildVC:messageVC title:@"卡券" image:@"tabbar_voucher_normal" selectedImage:@"tabbar_voucher_select"];
    
    MyViewController *myVC = [[MyViewController alloc] init];
    [self setChildVC:myVC title:@"我的" image:@"tabbar_my_normal" selectedImage:@"tabbar_my_select"];
    
}

- (void) setChildVC:(UIViewController *)childVC title:(NSString *) title image:(NSString *) image selectedImage:(NSString *) selectedImage {
    
    childVC.tabBarItem.title = title;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVC.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    CESNavigationController *nav = [[CESNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"item name = %@", item.title);
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animationWithIndex:index];
    if([item.title isEqualToString:@"发现"])
    {
        // 也可以判断标题,然后做自己想做的事<img alt="得意" src="http://static.blog.csdn.net/xheditor/xheditor_emot/default/proud.gif" />
    }
}
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.2;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
}


@end
