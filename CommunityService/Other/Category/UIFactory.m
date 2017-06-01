//
//  UIFactory.m
//  PocketShop
//  创建导航栏的button
//  Created by zhuhao on 14-3-26.
//  Copyright (c) 2014年 jkrm. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+ (UIBarButtonItem*)createBackBarButtonItemWithTarget:(id)target action:(SEL)action{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 25, 25);
    leftButton.titleLabel.font = Nav_Back_Font_M;
//    [leftButton setTitleColor:Theme_Color_Pink forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftButton.adjustsImageWhenHighlighted = NO;

    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    /*
      [leftButton setTitle:@"返回" forState:UIControlStateNormal];
      [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, leftButton.titleLabel.bounds.size.width)];
    */
//    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -35, 0, 0)];//zhj 2016.3.13
    
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    return leftBtn;
}

+ (UIBarButtonItem*)createCloseBarButtonItemWithTarget:(id)target action:(SEL)action{
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 40, 45);
    leftButton.titleLabel.font = Nav_Back_Font_M;
    [leftButton setTitleColor:Theme_Color_Pink forState:UIControlStateNormal];
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.adjustsImageWhenHighlighted = NO;

    [leftButton setImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -2, 0, leftButton.titleLabel.bounds.size.width)];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    return leftBtn;
}

+ (UIBarButtonItem*)createBarButtonItemWithTitle:(NSString*)title addTarget:(id)target action:(SEL)action{
   
    
    CGSize size = [Tool calculteTheSizeWithContent:title rect:CGSizeMake(200, 45) font:[UIFont systemFontOfSize:14.0]];
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, size.width + 20, 45);
    leftButton.titleLabel.font = Nav_Back_Font_M;
    [leftButton setTitleColor:Theme_Color_White forState:UIControlStateNormal];
    leftButton.adjustsImageWhenHighlighted = NO;

    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftButton];

    return leftBtn;
}

+ (UIBarButtonItem*)createBarButtonItemWithTitle2:(NSString*)title addTarget:(id)target action:(SEL)action{
    
    UIButton *leftButton = [[UIButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 72, 45);
    leftButton.titleLabel.font = Nav_Back_Font_M;
    //    [leftButton setTitleColor:Nav_BAR_ITEM_COLOR forState:UIControlStateNormal];
    [leftButton setTitle:title forState:UIControlStateNormal];
    leftButton.adjustsImageWhenDisabled = NO;

    [leftButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    return leftBtn;
}

+ (UITabBarItem*) createTabbarItem:(NSString*)title withImage:(NSString*)unimg withHeightLightImage:(NSString*)highImg
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:unimg] selectedImage:[UIImage imageNamed:highImg]];
    item.tag = 0;
    UIImage* image = [UIImage imageNamed: highImg];
    if ([image respondsToSelector: @selector(imageWithRenderingMode:)])
        [item setSelectedImage: [image imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    
    item.imageInsets  = UIEdgeInsetsMake(6, 0, -6, 0);
    
    return item;
}

+ (UILabel*) createThemeLabel{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.font = Theme_ContentFont_L;
    label.textColor = BASED_TEXT_BLACK_COLOR;
    
    return label;
}

@end
