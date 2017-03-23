//
//  CESNewFeatureCell.m
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import "CESNewFeatureCell.h"
#import "CESTabBarController.h"

@interface CESNewFeatureCell()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIButton *startButton;

@end


@implementation CESNewFeatureCell

- (UIButton *)startButton
{
    if (_startButton == nil) {
        
        UIButton *startBtn = [[UIButton alloc] initWithFrame:self.bounds];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        // 注意:一定要加载contentView
        [self.contentView addSubview:imageV];
        
    }
    return _imageView;
}

// 布局子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
}

// 判断当前cell是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1) { // 最后一页,显示分享和开始按钮
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
        
        
    }else{ // 非最后一页，隐藏分享和开始按钮
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

// 点击开始微博的时候调用

- (void)start
{
    // 进入tabBarVc
    CESTabBarController *tabBarVc = [[CESTabBarController alloc] init];
    
    // 切换根控制器:可以直接把之前的根控制器清空
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
    
}

@end
