//
//  UIFactory.h
//  PocketShop
//
//  Created by zhuhao on 14-3-26.
//  Copyright (c) 2014年 jkrm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFactory : NSObject

+ (UIBarButtonItem*)createBackBarButtonItemWithTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem*)createCloseBarButtonItemWithTarget:(id)target action:(SEL)action;

+ (UIBarButtonItem*)createBarButtonItemWithTitle:(NSString*)title addTarget:(id)target action:(SEL)action;


+ (UIBarButtonItem*)createBarButtonItemWithTitle2:(NSString*)title addTarget:(id)target action:(SEL)action;

+ (UITabBarItem*) createTabbarItem:(NSString*)title withImage:(NSString*)unimg withHeightLightImage:(NSString*)highImg;

+ (UILabel*) createThemeLabel;

@end
