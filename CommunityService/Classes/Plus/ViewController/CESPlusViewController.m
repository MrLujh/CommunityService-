//
//  TBPlusViewController.m
//  TabbarBeyondClick
//
//  Created by lujh on 2017/4/18.
//  Copyright © 2017年 lujh. All rights reserved.
//

#import "CESPlusViewController.h"

@interface CESPlusViewController ()

@end

@implementation CESPlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self setupNavigationbarBack];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_ios7"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

//在页面消失的时候就让navigationbar还原样式
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

#pragma mark -初始化导航栏

- (void)setupNavigationbarBack {
    
    UIButton *leftButton = [[UIButton alloc] init];
    leftButton.frame = CGRectMake(0, 0, 12, 21);
    leftButton.adjustsImageWhenHighlighted = NO;
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    spaceItem.width = -7;
    
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftButtonItem];
    
}

#pragma mark -导航栏返回按钮

- (void)backAction {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
