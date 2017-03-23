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
#import "CESNavigationController.h"
#import "MyViewController.h"
#import "CESTabBarView.h"
#import "CESTabBarButton.h"
@interface CESTabBarController ()<SelectTabarItmDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) CESTabBarView *customTabBarView;

@end

@implementation CESTabBarController

//view将要消失，调用该方法
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    // 设置tabBar
    [self setUpTabBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
}

#pragma mark -设置tabBar

- (void)setUpTabBar
{
    
    if (!_customTabBarView) {
        
        for (UIView *view in self.tabBar.subviews) {
            
            [view removeFromSuperview];
        }
        
        __weak typeof (self) weakSelf = self;
        
        _customTabBarView = [[CESTabBarView alloc] initWithFrame:self.tabBar.bounds];
        _customTabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarbg"]];
        _customTabBarView.controllers = self.childViewControllers;
        _customTabBarView.selectTabarItmDelegate = self;
        
        CESTabBarButton *tabBtn = [self.customTabBarView.items objectAtIndex:0];
        tabBtn.badgeStyle = TabItemBadgeStyleNumber;
        tabBtn.badge = 9;
        
        CESTabBarButton *tabBtn1 = [self.customTabBarView.items objectAtIndex:1];
        tabBtn1.badgeStyle = TabItemBadgeStyleNumber;
        tabBtn1.badge = 999;
        
        CESTabBarButton *tabBtn2 = [self.customTabBarView.items objectAtIndex:2];
        tabBtn2.badgeStyle = TabItemBadgeStyleNumber;
        tabBtn2.badge = 66;
        
        CESTabBarButton *tabBtn3 = [self.customTabBarView.items objectAtIndex:3];
        tabBtn3.badgeStyle = TabItemBadgeStyleDot;
        
        _customTabBarView.block = ^(NSInteger integer){
            weakSelf.selectedIndex = integer;
        };
        [self.tabBar addSubview:_customTabBarView];
    }

}
#pragma mark -初始化所有的子控制器

- (void)setupAllChildViewControllers
{
    
    [self setupControllersWithClass:[HomeViewController class] title:@"首页" image:@"tabbar_home_normal" seletedImage:@"tabbar_home_select" NibName:nil];
    [self setupControllersWithClass:[FindViewController class] title:@"发现" image:@"tabbar_find_normal" seletedImage:@"tabbar_find_select" NibName:nil];
    
    [self setupControllersWithClass:[VoucherViewController class] title:@"卡券" image:@"tabbar_voucher_normal" seletedImage:@"tabbar_voucher_select" NibName:nil];
    
    
    [self setupControllersWithClass:[MyViewController class] title:@"我的" image:@"tabbar_my_normal" seletedImage:@"tabbar_my_select" NibName:nil];
    
}

#pragma mark - 添加一个子控制器
/**
 *  初始化一个子控制器
 *
 *  @param class                子控制器
 *  @param imageStr             图标
 *  @param selectedImage     选中图标
 *  @param title 标题
 */
- (void)setupControllersWithClass:(Class)class title:(NSString *)title image:(NSString*)imageStr seletedImage:(NSString *)selectedImage NibName:(NSString *)name{
    
    //创建子导航控制器、Controller控制器
    UIViewController *vc = [[class alloc] initWithNibName:name bundle:nil];
    CESNavigationController *na = [[CESNavigationController alloc]initWithRootViewController:vc];
    vc.navigationItem.title = title;
    na.tabBarItem.title = title;
    na.tabBarItem.image = [UIImage imageNamed:imageStr];
    na.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:na];
    
}

#pragma mark -SelectTabarItmDelegate

- (void)selectTabarItem:(NSInteger)tag {

    NSLog(@"%ld",(long)tag);
    
}


@end
