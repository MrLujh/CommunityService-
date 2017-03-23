//
//  CESTabBarButton.h
//  CommunityService
//
//  Created by 家浩 on 2016/12/10.
//  Copyright © 2016年 卢家浩. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TabItemBadgeStyle) {
    
    TabItemBadgeStyleNone = 0,
    TabItemBadgeStyleNumber = 1, // 数字样式
    TabItemBadgeStyleDot = 2, // 小圆点
};

@interface CESTabBarButton : UIButton

@property (nonatomic, assign) TabItemBadgeStyle badgeStyle;

@property (nonatomic, assign) NSInteger badge;

@property (nonatomic,assign)BOOL isHideBadgeBtn;


@end
