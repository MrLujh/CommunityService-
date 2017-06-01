//
//  CESBaseViewController.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "CESBaseViewController.h"

@interface CESBaseViewController ()

@property (nonatomic, retain) UIView* overlayView;
@property (nonatomic, retain) UIView* bgview;
@property (nonatomic, retain) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, retain) UIImageView *loadingImageView;

@end

@implementation CESBaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (iOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    self.view.backgroundColor = ViewController_BackGround;
    
    //导航栏 返回 按钮
    NSArray *viewControllers = self.navigationController.viewControllers;
    
    if (viewControllers.count > 1){
        
        [self.navigationItem setHidesBackButton:NO animated:NO];
        
        UIBarButtonItem *leftBarButtonItem = [UIFactory createBackBarButtonItemWithTarget:self action:@selector(backAction)];
        
        if (iOS7) {
            
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            negativeSpacer.width = -15;
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarButtonItem];
            
        }else{
            
            self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        }
        
        //返回的手势
        UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSweepGesture:)];
        gesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:gesture];
        
        
    }else{
        
        [self.navigationItem setHidesBackButton:YES animated:NO];
        
    }
    
    
    // 正在加载  遮罩层
    _overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _overlayView.hidden = YES;
    
    //添加空事件
    UITapGestureRecognizer *tableTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    
    [_overlayView addGestureRecognizer:tableTap];
    //    _overlayView.alpha = 0.5;
    [self.view addSubview:_overlayView];

    
    
    //创建UIImageView，添加到界面
    self.loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KUIScreenWidth-100)/2, (KUIScreenHeight-100-64-20)/2, 100, 100)];
    [_overlayView addSubview:self.loadingImageView];
    //创建一个数组，数组中按顺序添加要播放的图片（图片为静态的图片）
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i = 1; i<= 15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loding-%d.png",i]];
        [imgArray addObject:image];
    }
    //把存有UIImage的数组赋给动画图片数组
    self.loadingImageView.animationImages = imgArray;
    //设置执行一次完整动画的时长
    self.loadingImageView.animationDuration = 5*0.15;
    //动画重复次数 （0为重复播放）
    self.loadingImageView.animationRepeatCount = 0;
    //开始播放动画
    //    [self.loadingImageView startAnimating];
    //停止播放动画  - (void)stopAnimating;
    //判断是否正在执行动画  - (BOOL)isAnimating;
    
}


- (void)backSweepGesture:(UISwipeGestureRecognizer*)gesture{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -
#pragma mark Action

- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark private tool

- (void)showLoading:(BOOL)isLoading {
    
    [self.view bringSubviewToFront:_overlayView];
    
    if (isLoading) {
        
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             _overlayView.hidden = NO;
                             _overlayView.backgroundColor = [UIColor colorWithRed:0.447 green:0.456 blue:0.471 alpha:0.1];
                             
                             //                             [_loadingIndicator startAnimating];
                             [self.loadingImageView startAnimating];
                             
                         }
         
                         completion:^(BOOL finished) {
                         }];
        
    } else {
        
        [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             _overlayView.alpha = 0.1;
                             
                         }
                         completion:^(BOOL finished) {
                             _overlayView.alpha = 1;
                             //                             [_loadingIndicator stopAnimating];
                             [self.loadingImageView stopAnimating];
                             
                             _overlayView.hidden = YES;
                         }];
    }
}


- (NSString*)getFilePath:(NSString*)filename{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    
    NSString *filePath=[plistPath1 stringByAppendingPathComponent:filename];
    
    return filePath;
    
}

@end
